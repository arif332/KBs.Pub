#!/bin/bash

if [ -f /var/tmp/setup_hosts.sh ];
then
	exit 0
fi

cat >> /etc/hosts <<EOF
192.168.56.53    k18master
192.168.56.54    k18worker1
192.168.56.55    k18worker2
EOF

sudo sed -i 's/127.0.1.1/#127.0.1.1/g' /etc/hosts

touch /var/tmp/setup_hosts.sh