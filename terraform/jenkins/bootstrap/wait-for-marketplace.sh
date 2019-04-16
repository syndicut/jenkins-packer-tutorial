#!/bin/sh

TIMEOUT=300

for i in `seq $TIMEOUT` ; do
	grep -i "yc-setup: Done" /var/log/yc-setup.log > /dev/null 2>&1

	result=$?
	if [ $result -eq 0 ] ; then
	  exit 0
	fi
  echo "Waiting for Marketplace setup...$i"
	sleep 1
done
echo "Operation timed out" >&2
exit 1
