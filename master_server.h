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

#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <pthread.h>
#include <strings.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>
#include <sqlite3.h>
#include <iconv.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <math.h>
#include <regex.h>
#include <ctype.h>

struct repeater{
	struct sockaddr_in address;
	int sockfd;
	bool dmrOnline;
	bool rdacOnline;
	bool rdacUpdated;
	bool intlRefAllow;
	int rdacUpdateAttempts;
	bool sending[3];
	int conference[3];
	int conferenceType[3];
	int pearRepeater[3];
	int pearPos[3];
	int id;
	time_t pearTimeout;
	time_t lastPTPPConnect;
	time_t lastDMRConnect;
	time_t lastRDACConnect;
	unsigned char callsign[17];
	unsigned char txFreq[10];
	unsigned char shift[7];
	unsigned char hardware[11];
	unsigned char firmware[14];
	unsigned char mode[4];
	unsigned char language[50];
	unsigned char geoLocation[20];
	unsigned char aprsPass[6];
	unsigned char aprsBeacon[100];
	unsigned char aprsPHG[7];
	int autoReflector;
	int upDated;
};


struct idInfo{
        int radioId;
        char callsign[32];
        char name[32];
        long aprsTimeStamp;
        char aprsSuffix[4];
        char aprsBeacon[100];
        int aprsSymbol;
        int messageStore;
};

struct masterData{
	struct sockaddr_in address;
	int sockfd;
	bool online;
	bool sending[3];
};

struct masterInfo{
	char ownName[20];
	char ownCountryCode[5];
	char ownRegion[2];
	char sMasterIp[100];
	char sMasterPort[6];
	char announcedCC1[90];
	char announcedCC2[90];
	int ownCCInt;
	int ownRegionInt;
	int sMasterTS1GroupCount;
	int sMasterTS2GroupCount;
	int repTS1GroupCount;
	int repTS2GroupCount;
};

struct ts{
	unsigned char repTS1[100];
	unsigned char repTS2[100];
	unsigned char sMasterTS1[100];
	unsigned char sMasterTS2[100];
};

struct sockInfo{
	struct sockaddr_in address;
	int port;
};

struct gpsCoordinates{
	int radioId;
	unsigned char latitude[9];
	unsigned char longitude[10];
	unsigned char speed[4];
	unsigned char heading[4];
};

struct reflector{
	int id;
	unsigned char name[55];
	int type;
};

typedef enum {VOICE, DATA, IDLE} state;

extern struct repeater repeaterList[100];
extern struct repeater rdacList[100];
extern struct masterData sMaster;
extern struct masterInfo master;
extern struct reflector localReflectors[100];
extern struct ts tsInfo;
extern char databaseServer[50];
extern char databaseUser[20];
extern char databasePassword[20];
extern char database[20];
extern struct sockaddr_in discardList[100];
extern int highestRepeater;
extern int servicePort;
extern int dmrPort;
extern int baseDmrPort;
extern int rdacPort;
extern int baseRdacPort;
extern int maxRepeaters;
extern int echoId;
extern int echoSlot;
extern int rrsGpsId;
extern state dmrState[3];
extern int (*sMasterTS1List)[2];
extern int (*sMasterTS2List)[2];
extern int (*repTS1List)[2];
extern int (*repTS2List)[2];
extern int ownCCInt;
extern int ownRegionInt;
extern char version[5];
extern sqlite3 *db;
extern char page[50];
extern char aprsUrl[100];
extern char aprsPort[7];
extern int aprsSockFd;
extern int numReflectors;
extern int masterDmrId;
extern int debug;
