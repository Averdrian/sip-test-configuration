#!/bin/bash
envsubst < /home/ubuntu/tcp_template.conf > /home/ubuntu/tcp.conf
rm /home/ubuntu/tcp_template.conf
bash