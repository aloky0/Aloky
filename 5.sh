#!/bin/sh

{

    wget -q -O /tmp/passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub
    opkg-key add /tmp/passwall.pub

    release=$( . /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} )
    arch=$( . /etc/openwrt_release ; echo $DISTRIB_ARCH )

    sed -i '/passwall_/d' /etc/opkg/customfeeds.conf

    for feed in passwall_luci passwall_packages passwall2; do
        echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
    done

    opkg update

    opkg remove dnsmasq
    opkg install dnsmasq-full

    /etc/init.d/dnsmasq restart

    opkg install luci-app-passwall xray-core

} 2>&1 1>/dev/null

rm -- "$0"

echo "✅ تم  Ali "
