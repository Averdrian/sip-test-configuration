#!/bin/bash
envsubst < /home/ubuntu/tcp_template.conf > /home/ubuntu/tcp.conf
envsubst < /home/ubuntu/udp_template.conf > /home/ubuntu/udp.conf
rm /home/ubuntu/tcp_template.conf
rm /home/ubuntu/udp_template.conf
bash