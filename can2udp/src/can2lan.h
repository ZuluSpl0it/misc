/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <info@gerhard-bertelsmann.de> wrote this file. As long as you retain this
 * notice you can do whatever you want with this stuff. If we meet some day,
 * and you think this stuff is worth it, you can buy me a beer in return
 * Gerhard Bertelsmann
 * ----------------------------------------------------------------------------
 */

/* Thanks to Stefan Krauss and the SocketCAN team
 */
#ifndef _CAN2LAN_H_
#define _CAN2LAN_H_
#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <errno.h>
#include <ctype.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <net/if.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <time.h>
#include <linux/can.h>

#define MAX_TCP_CONN	16		/* max TCP clients */
#define MAXDG   	4096		/* maximum datagram size */
#define MAXUDP  	16		/* maximum datagram size */
#define MAX(a,b)	((a) > (b) ? (a) : (b))
#define debug_print(...) \
            do { if (DEBUG) fprintf(stderr, ##__VA_ARGS__); } while (0)


static const int MAXPENDING = 16;	/* max outstanding tcp connections */
unsigned char netframe[MAXDG];
#endif /* _CAN2LAN_H_ */

