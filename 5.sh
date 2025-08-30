#!/bin/sh v2ray

wget https://downloads.sourceforge.net/project/v2raya/openwrt/v2raya.pub -O /etc/opkg/keys/94cc2a834fb0aa03

echo "src/gz v2raya https://downloads.sourceforge.net/project/v2raya/openwrt/$(. /etc/openwrt_release && echo \"$DISTRIB_ARCH\")" | tee -a "/etc/opkg/customfeeds.conf"

opkg update

opkg install v2raya

opkg install kmod-nft-tproxy

opkg install xray-core

opkg install v2fly-geoip v2fly-geosite

opkg install luci-app-v2raya


mkdir -p /usr/share/nftables.d/chain-pre/mangle_postrouting/

echo "ip ttl set 65" > /usr/share/nftables.d/chain-pre/mangle_postrouting/01-set-ttl.nft

fw4 reload

rm -- "$0"
