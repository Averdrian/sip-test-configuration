####################################################################################################
#
# Adapted from https://github.com/signalwire/freeswitch/blob/master/docker/release/Dockerfile
#
####################################################################################################

# vim:set ft=dockerfile:
    FROM debian:bullseye

    # Source Dockerfile:
    # https://github.com/docker-library/postgres/blob/master/9.4/Dockerfile
    
    # explicitly set user/group IDs
    RUN groupadd -r freeswitch --gid=999 && useradd -r -g freeswitch --uid=999 freeswitch

    # grab gosu for easy step-down from root
    RUN apt-get update && apt-get install -y gnupg2 sngrep
    ARG GPG_KEYS="B42F6819007F00F88E364FD4036A9C25BF357DD4"
    RUN gpg --keyserver keyserver.ubuntu.com --recv-keys "$GPG_KEYS" \
        || gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEYS" \
        || gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEYS"
    RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl && rm -rf /var/lib/apt/lists/*
    RUN curl -L -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
        && curl -L -o /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
        && gpg --verify /usr/local/bin/gosu.asc \
        && rm /usr/local/bin/gosu.asc \
        && chmod +x /usr/local/bin/gosu \
        && apt-get purge -y --auto-remove ca-certificates curl
    
    # make the "en_US.UTF-8" locale so freeswitch will be utf-8 enabled by default
    RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
    ENV LANG en_US.utf8
    
    # https://freeswitch.org/confluence/display/FREESWITCH/Debian+8+Jessie#Debian8Jessie-InstallingfromDebianpackages
    
    ENV FS_PAT="pat_nxbLR39MRrsTaFXCwpZqas1h"
    RUN apt-get update && apt-get install -y curl lsb-release \
        && curl -u "i.ribakov@zaleos.net:$FS_PAT" -L -o /usr/share/keyrings/signalwire-freeswitch-repo.gpg https://freeswitch.signalwire.com/repo/deb/debian-release/signalwire-freeswitch-repo.gpg \
        && echo "machine freeswitch.signalwire.com login i.ribakov@zaleos.net password $FS_PAT" > /etc/apt/auth.conf \
        && echo "machine files.freeswitch.org login i.ribakov@zaleos.net password $FS_PAT" >> /etc/apt/auth.conf \
        && echo "deb [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list \
        && echo "deb-src [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list \
        && apt-get purge -y --auto-remove curl
    
    # Module list based on the minimal config:
    # https://github.com/signalwire/freeswitch/blob/master/conf/minimal/modules.conf
    # Added also mod_http_cache to playback remote files
    RUN apt-get update && apt-get install -y freeswitch \
        freeswitch-conf-minimal \
        freeswitch-mod-dptools \
        freeswitch-mod-event-socket \
        freeswitch-mod-commands \
        freeswitch-mod-dialplan-xml \
        freeswitch-mod-sofia \
        freeswitch-mod-sndfile \
        freeswitch-mod-console \
        freeswitch-mod-http-cache \
        freeswitch-sounds-en-us-callie \
        freeswitch-mod-lua \
        && apt-get clean && rm -rf /var/lib/apt/lists/*
    
    # Clean up
    RUN apt-get autoremove
    
    COPY entrypoint.sh /
    RUN chmod +x /entrypoint.sh
    ## Ports
    # Open the container up to the world.
    ### 8021 fs_cli, 5060 5061 5080 5081 sip and sips, 64535-65535 rtp
    EXPOSE 8021/tcp
    EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
    EXPOSE 5061/tcp 5061/udp 5081/tcp 5081/udp
    EXPOSE 7443/tcp
    EXPOSE 5070/udp 5070/tcp
    EXPOSE 64535-65535/udp
    EXPOSE 16384-32768/udp
    
    
    # Volumes
    ## Freeswitch Configuration
    VOLUME ["/etc/freeswitch"]
    ## Tmp so we can get core dumps out
    VOLUME ["/tmp"]
    
    # Limits Configuration
    COPY    freeswitch.limits.conf /etc/security/limits.d/
    
    # Healthcheck to make sure the service is running
    SHELL       ["/bin/bash"]
    HEALTHCHECK --interval=15s --timeout=5s \
        CMD  fs_cli -x status | grep -q ^UP || exit 1
    
    ## Add additional things here
    
    ##
    
    ENTRYPOINT ["/entrypoint.sh"]
    CMD ["freeswitch"]
    # CMD ["bash"]