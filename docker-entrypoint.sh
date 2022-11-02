#!/bin/sh
set -e

if [ ! -f app.py ]; then
	git clone -q ${REPO_URL} .
	rm -rf base/rules.db
	echo "App Initialized"
elif [ -n "$AUTOUPDATE" ] && [ "$AUTOUPDATE" != 0 ]; then
	mv base/rules.db base/直播.txt /tmp
	ls -A1 | xargs rm -rf
	git clone -q ${REPO_URL} .
	mv -f /tmp/rules.db /tmp/直播.txt base/
	echo "App Updated"
fi

if [ ! -f /etc/supervisord.conf ]; then
	cp /etc/supervisord.init /etc/supervisord.conf
	echo "Supervisord Initialized"
fi

exec "$@"
