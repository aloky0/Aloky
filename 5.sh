#!/bin/sh

{
    opkg update
    sleep 10

    opkg install unzip -qq
    sleep 10

    wget -qO p.zip https://github.com/xiaorouji/openwrt-passwall2/releases/download/25.7.15-1/passwall_packages_ipk_aarch64_cortex-a53.zip
    sleep 10

    unzip -q p.zip -d p
    sleep 10
    rm -f p.zip

    cd p || exit 1
    sleep 1

    opkg update
    sleep 25

    opkg install ./* -qq
    sleep 25

    cd ..
    rm -rf p
    sleep 10

    rm -- "$0"
} >/dev/null 2>&1
