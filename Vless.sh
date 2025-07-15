#!/bin/sh

iptables -t mangle -D POSTROUTING -o br-lan -j TTL --ttl-set 65 2>/dev/null
iptables -t mangle -A POSTROUTING -o br-lan -j TTL --ttl-set 65


if ! grep -q "TTL --ttl-set 65" /etc/rc.local; then
  sed -i '/exit 0/i iptables -t mangle -A POSTROUTING -o br-lan -j TTL --ttl-set 65' /etc/rc.local
fi


rm -- "$0"
