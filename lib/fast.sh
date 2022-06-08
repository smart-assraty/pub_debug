#!/bin/bash
service network-manager stop
iw phy phy0 interface add pub0 type ibss
ip link set up mtu 1532 dev pub0
iw dev pub0 ibss join PubMesh 2412
batctl if create
batctl if add pub0
ifconfig pub0 up
ifconfig bat0 up
batctl n
