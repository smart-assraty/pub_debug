#!/bin/bash
PACKAGES="build-essential checkinstall pkg-config curl libnl-genl-3-200 libnl-3-dev libnl-genl-3-200 libnl-genl-3-dev git gettext-base net-tools wireless-tools batctl"
apt update && apt upgrade -y
apt install -y $PACKAGES
cd /usr/src
modprobe batman-adv
service NetworkManager stop
iw phy phy0 interface add pub0 type ibss
ip link set up mtu 1532 dev pub0
iw dev pub0 ibss join PubMesh 2412
batctl if create
batctl if add pub0
ifconfig pub0 up
ifconfig bat0 up
batctl n
