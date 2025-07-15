#!/bin/sh

opkg update && opkg install unzip

cd /tmp
wget -O passwall.zip https://github.com/xiaorouji/openwrt-passwall2/releases/download/25.1.1-1/passwall_packages_ipk_aarch64_cortex-a53.zip

unzip passwall_packages_ipk_aarch64_cortex-a53.zip -d passwall
cd passwall

opkg update
opkg install ./*

cd ..
rm -rf passwall passwall.zip

rm -- "$0"
