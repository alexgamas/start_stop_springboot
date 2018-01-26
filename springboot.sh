#!/bin/sh

# Quick start-stop-daemon example, derived from Debian /etc/init.d/ssh
set -e

NAME=springboot
PIDFILE=/var/run/$NAME.pid

DAEMON=/usr/lib/jvm/java-8-openjdk-amd64/bin/java
DAEMON_OPTS="-jar /app/springboot.jar"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
        echo -n "Starting daemon: "$NAME" "
	# --verbose --background --make-pidfile
	start-stop-daemon --start --verbose --background --pidfile $PIDFILE --make-pidfile  --exec "$DAEMON" -- $DAEMON_OPTS
        echo "."
	;;
  stop)
        echo -n "Stopping daemon: "$NAME
	start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE
        echo "."
	;;
  restart)
        echo -n "Restarting daemon: "$NAME
	start-stop-daemon --stop --quiet --oknodo --retry 30 --pidfile $PIDFILE
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
	echo "."
	;;

  *)
	echo "Usage: "$1" {start|stop|restart}"
	exit 1
esac

exit 0

