#!/bin/sh

opkg update
sleep 10

opkg install unzip
sleep 10

wget -O p.zip https://github.com/xiaorouji/openwrt-passwall2/releases/download/25.1.1-1/passwall_packages_ipk_aarch64_cortex-a53.zip
sleep 10

unzip p.zip -d p
sleep 10
rm -rf p.zip

cd p
sleep 1

opkg update
sleep 25

opkg install ./*
sleep 25

cd ..
rm -rf p 
sleep 10

rm -- "$0"
