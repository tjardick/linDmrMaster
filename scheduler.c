/*
 *  Linux DMR Master server
    Copyright (C) 2014 Wim Hofman

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#include "master_server.h"

void sendAprsBeacon();
sqlite3 *openDatabase();
void closeDatabase();
void updateRepeaterTable();
void sendReflectorStatus();

void *scheduler(){
	time_t timeNow,beaconTime=0,dataBaseCleanTime,dmrCleanUpTime;
	int i, id, l;
	char SQLQUERY[200];
	sqlite3 *dbase;
	sqlite3_stmt *stmt;
	bool sending = false;

	syslog(LOG_NOTICE,"Scheduler thread started");
	time(&beaconTime);
	time(&dataBaseCleanTime);
	time(&dmrCleanUpTime);
	for(;;){
		sleep(10);
		time(&timeNow);

		//Send to sMaster if intl reflector is connected
		if (sMaster.online){
			sendReflectorStatus(sMaster.sockfd,sMaster.address,100);
		}

		//Send APRS beacons
		if (difftime(timeNow,beaconTime) > 1800){
			for(i=0;i<highestRepeater;i++){
				if (repeaterList[i].id != 0 && repeaterList[i].dmrOnline){
					sleep(1);
					sendAprsBeacon(repeaterList[i].callsign,repeaterList[i].aprsPass,repeaterList[i].geoLocation,repeaterList[i].aprsPHG,repeaterList[i].aprsBeacon);
				}
			}
			time(&beaconTime);
			syslog(LOG_NOTICE,"Send aprs beacons for connected repeaters");
		}
		
		
		//Cleanup registration database
		if (difftime(timeNow,dataBaseCleanTime) > 120){
			dbase = openDatabase();
			sprintf(SQLQUERY,"DELETE FROM rrs WHERE %lu-unixTime > 1900",time(NULL));
			if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
				syslog(LOG_NOTICE,"Failed to cleanup RRS database: %s",sqlite3_errmsg(dbase));
			}
			//Delete old traffic data
			sprintf(SQLQUERY,"DELETE FROM traffic WHERE %lu-timeStamp > 86400",time(NULL));
			if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
				syslog(LOG_NOTICE,"Failed to cleanup traffic database: %s",sqlite3_errmsg(dbase));
			}
			//Delete old voiceTraffic data
			sprintf(SQLQUERY,"DELETE FROM voiceTraffic WHERE %lu-timeStamp > 86400",time(NULL));
			if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
			syslog(LOG_NOTICE,"Failed to cleanup voiceTraffic database: %s",sqlite3_errmsg(dbase));
			}
				
			id = 0;
			sprintf(SQLQUERY,"SELECT repeaterId,callsign,txFreq,shift,hardware,firmware,mode,language,geoLocation,aprsPass,aprsBeacon,aprsPHG,autoReflector,intlRefAllow FROM repeaters WHERE upDated = 1");
			if (sqlite3_prepare_v2(dbase,SQLQUERY,-1,&stmt,0) == 0){
				while (sqlite3_step(stmt) == SQLITE_ROW){
					id = sqlite3_column_int(stmt,0);
					for(i=0;i<highestRepeater;i++){
						if(repeaterList[i].id == id && repeaterList[i].dmrOnline){
							sprintf(repeaterList[i].callsign,"%s",sqlite3_column_text(stmt,1));
							sprintf(repeaterList[i].txFreq,"%s",sqlite3_column_text(stmt,2));
							sprintf(repeaterList[i].shift,"%s",sqlite3_column_text(stmt,3));
							sprintf(repeaterList[i].hardware,"%s",sqlite3_column_text(stmt,4));
							sprintf(repeaterList[i].firmware,"%s",sqlite3_column_text(stmt,5));
							sprintf(repeaterList[i].mode,"%s",sqlite3_column_text(stmt,6));
							sprintf(repeaterList[i].language,"%s",sqlite3_column_text(stmt,7));
							sprintf(repeaterList[i].geoLocation,"%s",sqlite3_column_text(stmt,8));
							sprintf(repeaterList[i].aprsPass,"%s",sqlite3_column_text(stmt,9));
							sprintf(repeaterList[i].aprsBeacon,"%s",sqlite3_column_text(stmt,10));
							sprintf(repeaterList[i].aprsPHG,"%s",sqlite3_column_text(stmt,11));
							repeaterList[i].autoReflector = sqlite3_column_int(stmt,12);
							repeaterList[i].intlRefAllow = (sqlite3_column_int(stmt,13) == 1 ? true:false);
							syslog(LOG_NOTICE,"Repeater data changed from web %s %s %s %s %s %s %s %s %s %s %s %i on pos %i",repeaterList[i].callsign,repeaterList[i].hardware
							,repeaterList[i].firmware,repeaterList[i].mode,repeaterList[i].txFreq,repeaterList[i].shift,repeaterList[i].language
							,repeaterList[i].geoLocation,repeaterList[i].aprsPass,repeaterList[i].aprsBeacon,repeaterList[i].aprsPHG,repeaterList[i].autoReflector,i);
							repeaterList[i].conference[2] = repeaterList[i].autoReflector;
							if (repeaterList[i].pearRepeater[2] != 0){
								repeaterList[i].pearRepeater[2] = 0;
								repeaterList[repeaterList[i].pearPos[2]].pearRepeater[2] = 0;
							}
							if (repeaterList[i].conference[2] !=0){
								//If autoreflector is intl, send needed info to sMaster
								for(l=0;l<numReflectors;l++){
									if(localReflectors[l].id == repeaterList[i].conference[2]){
										repeaterList[i].conferenceType[2] = localReflectors[l].type;
										if(localReflectors[l].type == 1){
											if(sMaster.online){
												sendRepeaterInfo(sMaster.sockfd,sMaster.address,i);
												sendReflectorStatus(sMaster.sockfd,sMaster.address,i);
												sendTalkgroupInfo(sMaster.sockfd,sMaster.address,repeaterList[i].conference[2]);
											}
										}
									}
								}
							}
						}
					}
				}
				sqlite3_finalize(stmt);	
			}

			if (id !=0){
				sprintf(SQLQUERY,"UPDATE repeaters SET upDated = 0");
				if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
					syslog(LOG_NOTICE,"Failed to reset 'updated' in repeater table: %s",sqlite3_errmsg(dbase));
				}
			}
			closeDatabase(dbase);
			time(&dataBaseCleanTime);
		}

		//cleanup dmr not idle
		
		if (difftime(timeNow,dmrCleanUpTime) > 120){
			if (dmrState[1] != IDLE){
				for(i=0;i<highestRepeater;i++){
					if (repeaterList[i].sending[1]){
						sending = true;
						break;
					}
				}
				if (sMaster.sending[1]) sending = true;
				if (!sending){
					dmrState[1] = IDLE;
					syslog(LOG_NOTICE,"DMR state inconsistent on slot 1, settign IDLE");
				}
			}
			sending = false;

			if (dmrState[2] != IDLE){
				for(i=0;i<highestRepeater;i++){
					if (repeaterList[i].sending[2]){
						sending = true;
						break;
					}
				}
				if (sMaster.sending[2]) sending = true;
				if (!sending){
					dmrState[2] = IDLE;
					syslog(LOG_NOTICE,"DMR state inconsistent on slot 2, settign IDLE");
				}
			}
			time(&dmrCleanUpTime);
		}
	}
}
