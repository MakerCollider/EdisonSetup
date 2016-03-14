#!/bin/bash

cat << "EOF"

            __  __       _                ____      _ _ _     _
           |  \/  | __ _| | _____ _ __   / ___|___ | | (_) __| | ___ _ __
           | |\/| |/ _` | |/ / _ \ '__| | |   / _ \| | | |/ _` |/ _ \ '__|
           | |  | | (_| |   <  __/ |    | |__| (_) | | | | (_| |  __/ |
           |_|  |_|\__,_|_|\_\___|_|     \____\___/|_|_|_|\__,_|\___|_|
EOF

IOTKIT="/etc/opkg/iotkit.conf"
TIMESYNC="/etc/systemd/timesyncd.conf"
ALSACONF="/etc/asound.conf"

echo "## 1    ## Set edisons system configure(need reboot)"
sleep 2
configure_edison --setup

echo "## 2    ## Update opkg repositroy"
echo "src intelgalactic http://iotdk.intel.com/repos/3.0/intelgalactic/opkg/i586/" > ${IOTKIT}
echo "src/gz all http://iotdk.intel.com/repos/3.0/iotdk/all" >> ${IOTKIT}
echo "src/gz core2-32 http://iotdk.intel.com/repos/3.0/iotdk/core2-32" >> ${IOTKIT}
echo "src/gz core2-32-intel-common http://iotdk.intel.com/repos/3.0/iotdk/core2-32-intel-common" >> ${IOTKIT}
echo "src/gz i586 http://iotdk.intel.com/repos/3.0/iotdk/i586" >> ${IOTKIT}
echo "src/gz intel_core2_32 http://iotdk.intel.com/repos/3.0/iotdk/intel_core2_32" >> ${IOTKIT}
echo "src/gz x86 http://iotdk.intel.com/repos/3.0/iotdk/x86" >> ${IOTKIT}
opkg update

echo "## 3    ## Update NTP server and timezone"
echo "[Time]" > ${TIMESYNC}
echo "Servers= 0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" >> ${TIMESYNC}
timedatectl set-timezone Asia/Hong_Kong

echo "## 4    ## Set alsa configure"
echo "defaults.pcm.card 2" > ${ALSACONF}
echo "defaults.pcm.device 0" >> ${ALSACONF}
echo "defaults.pcm.subdevice 0" >> ${ALSACONF}

echo "## 5    ## All finish, reboot"
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo "reboot"
reboot