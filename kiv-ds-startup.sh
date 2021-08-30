#!/bin/bash
LOGFILE=/tmp/kiv-ds-startup.log
echo "BEGIN" >> $LOGFILE

# Start the OpenSSH daemon
echo "Starting sshd." >> $LOGFILE
/usr/sbin/sshd -D

# EOF
