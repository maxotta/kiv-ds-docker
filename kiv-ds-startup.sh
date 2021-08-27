#!/bin/bash

# Determine and configure the MCast DNS interface
AVAHI_DAEMON_CONF=/etc/avahi/avahi-daemon.conf
MDNS_SUBNET=$1
MCAST_IFACE=`route -n | awk "/${MDNS_SUBNET}/{ print \\$8 }"`
(grep -q ^allow-interfaces= $AVAHI_DAEMON_CONF || sed -i "/^\[server\]$/a allow-interfaces=$MCAST_IFACE" $AVAHI_DAEMON_CONF) && (grep -q ^allow-interfaces= $AVAHI_DAEMON_CONF && sed -i "s/^allow-interfaces=.*$/allow-interfaces=$MCAST_IFACE/g" $AVAHI_DAEMON_CONF)
(grep -q ^deny-interfaces= $AVAHI_DAEMON_CONF || sed -i '/^\[server\]$/a deny-interfaces=lo' $AVAHI_DAEMON_CONF) && (grep -q ^deny-interfaces= $AVAHI_DAEMON_CONF && sed -i 's/^deny-interfaces=.*$/deny-interfaces=lo/g' $AVAHI_DAEMON_CONF)

# Start the OpenSSH daemon
/usr/sbin/sshd -D
# Start the mDNS daemon
/usr/sbin/avahi-daemon -D
