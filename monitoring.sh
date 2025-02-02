# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: masayama <masayama@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/02 22:45:38 by masayama          #+#    #+#              #
#    Updated: 2025/02/03 01:01:51 by masayama         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

SYSTEM_ARCH=$(uname -srvmo)
PHYSICAL_CPU_COUNT=$(lscpu | grep "Socket(s):" | awk '{print $2}')
VIRTUAL_CPU_COUNT=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
USED_MEMORY=$(free -m | grep Mem | awk '{print $3}')
TOTAL_MEMORY=$(free -m | grep Mem | awk '{print $2}')
USED_MEMORY_PERCENT=$(echo "scale=2; $USED_MEMORY * 100.0 / $TOTAL_MEMORY" | bc)
TOTAL_DISK=$(df -h --block-size=G --total | grep total | awk '{print $2}' | cut -f 1 -d G)
USED_DISK=$(df -h --block-size=G --total | grep total | awk '{print $3}' | cut -f 1 -d G)
USED_DISK_PERCENT=$(df -h --block-size=G --total | grep total | awk '{print $5}')
USED_CPU=$(mpstat | tail -n 1 | awk '{print 100 - $13}')
LAST_BOOT=$(who -b | awk '{print $3 " " $4}')
LVM_USE=$(lsblk | grep -q lvm && echo yes || echo no)
CONNECTIONS_TCP=$(ss -t state established | tail -n +2 | wc -l)
LOGIN_USER_COUNT=$(who | wc -l)
IP_ADD=$(hostname -I)
MAC_ADD=$(ip link show | grep link/ether | awk '{print $2}')
SUDO_LOG=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall <<EOF
#Architecture: $SYSTEM_ARCH
#CPU physical: $PHYSICAL_CPU_COUNT
#vCPU: $VIRTUAL_CPU_COUNT
#Memory Usage: $USED_MEMORY/$TOTAL_MEMORY MB ($USED_MEMORY_PERCENT%)
#Disk Usage: $USED_DISK/$TOTAL_DISK GB ($USED_DISK_PERCENT)
#CPU Load: $USED_CPU%
#Last boot: $LAST_BOOT
#LVM use: $LVM_USE
#Connections TCP: $CONNECTIONS_TCP
#User log: $LOGIN_USER_COUNT
#Network: IP $IP_ADD ($MAC_ADD)
#Sudo: $SUDO_LOG cmd
EOF
