#!/bin/sh

RULE="$*"
RULE_HASH=$(echo $RULE | md5sum | cut -d " " -f 1)
RULE_SLEEP_PIDFILE=/tmp/$RULE_HASH.pid
EXPIRE_AFTER=30

if [ -f $RULE_SLEEP_PIDFILE ]; then
   # Rule has already been set: reset expiry timer
   kill -USR1 $(<$RULE_SLEEP_PIDFILE)
else
   iptables -t nat -I $*
   { /root/sleep2 $EXPIRE_AFTER $RULE_SLEEP_PIDFILE; iptables -t nat -D $*; rm -f $RULE_SLEEP_PIDFILE; } &
fi

