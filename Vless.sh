#!/bin/sh

mkdir -p /usr/share/nftables.d/chain-pre/mangle_postrouting/

echo "ip ttl set 65" > /usr/share/nftables.d/chain-pre/mangle_postrouting/01-set-ttl.nft

fw4 reload

rm -- "$0"
