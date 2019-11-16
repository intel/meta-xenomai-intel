#!/bin/sh

logger "xenomai starting initscript"

echo "/usr/lib/xenomai/lib" >> /etc/ld.so.conf
ldconfig

logger "xenomai initscript work done"

#job done, remove it from systemd services
systemctl disable initscript.service

logger "xenomai initscript disabled"
