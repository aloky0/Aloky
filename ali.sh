#!/bin/sh

wget https://downloads.sourceforge.net/project/v2raya/openwrt/v2raya.pub -O /etc/opkg/keys/94cc2a834fb0aa03
echo "src/gz v2raya https://downloads.sourceforge.net/project/v2raya/openwrt/$(. /etc/openwrt_release && echo \"$DISTRIB_ARCH\")" | tee -a "/etc/opkg/customfeeds.conf"

opkg update
opkg update
opkg update
opkg update
opkg update

opkg install v2raya
opkg install kmod-nft-tproxy
opkg install xray-core
opkg install luci-app-v2raya

uci set v2raya.config.enabled='1'
uci commit v2raya
/etc/init.d/v2raya start

rm -- "$0"