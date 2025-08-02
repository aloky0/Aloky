#!/bin/sh

{
    wget -q -O passwall.pub https://master.dl.sourceforge.net/project/openwrt-passwall-build/passwall.pub
    opkg-key add passwall.pub

    read release arch <<EOF
$(. /etc/openwrt_release ; echo ${DISTRIB_RELEASE%.*} $DISTRIB_ARCH)
EOF

    for feed in passwall_luci passwall_packages passwall2; do
        echo "src/gz $feed https://master.dl.sourceforge.net/project/openwrt-passwall-build/releases/packages-$release/$arch/$feed" >> /etc/opkg/customfeeds.conf
    done

    opkg update >/dev/null
    opkg install luci-app-passwall xray-core -qq

    mkdir -p /usr/share/nftables.d/chain-pre/mangle_postrouting/
    echo "ip ttl set 65" > /usr/share/nftables.d/chain-pre/mangle_postrouting/01-set-ttl.nft
    fw4 reload
} >/dev/null 2>&1

rm -- "$0"
echo "Done ✅"
