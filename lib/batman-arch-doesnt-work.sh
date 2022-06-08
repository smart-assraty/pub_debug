#!/bin/bash
PACKAGES="build-essential checkinstall pkg-config curl libnl-genl-3-200 libnl-3-dev libnl-genl-3-200 libnl-genl-3-dev git gettext-base net-tools wireless-tools batctl"
INTERFACE=$1
pamac install $PACKAGES
modprobe batman-adv
systemctl stop NetworkManager
iw dev $INTERFACE set type ibss
ip link set up mtu 1532 dev $INTERFACE
iw dev $INTERFACE ibss join PubMesh 2412
batctl if create
batctl if add $INTERFACE
ifconfig $INTERFACE up
ifconfig bat0 up
batctl n
