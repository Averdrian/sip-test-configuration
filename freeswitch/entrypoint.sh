#!/bin/bash
set -e

# Source docker-entrypoint.sh:
# https://github.com/docker-library/postgres/blob/master/9.4/docker-entrypoint.sh
# https://github.com/kovalyshyn/docker-freeswitch/blob/vanilla/docker-entrypoint.sh

if [ "$1" = 'freeswitch' ]; then

    if [ ! -f "/etc/freeswitch/freeswitch.xml" ]; then
        mkdir -p /etc/freeswitch/autoload_configs
        cp -varfn /usr/share/freeswitch/conf/minimal/freeswitch.xml /etc/freeswitch/
        cp -varfn /usr/share/freeswitch/conf/minimal/autoload_configs/sofia.conf.xml /etc/freeswitch/autoload_configs/
        cp -varfn /usr/share/freeswitch/conf/minimal/autoload_configs/console.conf.xml /etc/freeswitch/autoload_configs/
        cp -varfn /usr/share/freeswitch/conf/minimal/autoload_configs/switch.conf.xml /etc/freeswitch/autoload_configs/
    fi

    chown -R freeswitch:freeswitch /etc/freeswitch
    chown -R freeswitch:freeswitch /var/{run,lib}/freeswitch

    if [ -d /docker-entrypoint.d ]; then
        for f in /docker-entrypoint.d/*.sh; do
            [ -f "$f" ] && . "$f"
        done
    fi

    exec gosu freeswitch /usr/bin/freeswitch -u freeswitch -g freeswitch -nonat -c
fi

exec "$@"