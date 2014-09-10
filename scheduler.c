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

void *scheduler(){
	time_t timeNow,beaconTime=0;
	int i;
	char SQLQUERY[200];
        sqlite3 *dbase;
        sqlite3_stmt *stmt;

	syslog(LOG_NOTICE,"Scheduler thread started");
	for(;;){
		sleep(120);
		time(&timeNow);
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
                time(&timeNow);
                //Cleanup registration database
        	dbase = openDatabase();
                sprintf(SQLQUERY,"DELETE FROM rrs WHERE %lu-unixTime > 1900",time(NULL));
		syslog(LOG_NOTICE,"RRS cleanup query: %s",SQLQUERY);
	        if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
        	        syslog(LOG_NOTICE,"Failed to cleanup RRS database: %s",sqlite3_errmsg(dbase));
	        }
		//Delete old traffic data
                sprintf(SQLQUERY,"DELETE FROM traffic WHERE %lu-timeStamp > 86400",time(NULL));
                if (sqlite3_exec(dbase,SQLQUERY,0,0,0) != 0){
                        syslog(LOG_NOTICE,"Failed to cleanup RRS database: %s",sqlite3_errmsg(dbase));
                }

		closeDatabase(dbase);
	}
}
