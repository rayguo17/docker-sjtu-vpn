#!/bin/bash

echo -e "nameserver 202.120.2.101" >> /etc/resolv.conf
echo -e "nameserver 202.120.2.100">> /etc/resolv.conf

ipsec start
sleep 2
ipsec up sjtu-student
sleep 2
proxy socks -t tcp -p '0.0.0.0:1080'