#!/bin/sh

iptables -t mangle -D POSTROUTING -j TTL --ttl-set 65 2>/dev/null

iptables -t mangle -A POSTROUTING -j TTL --ttl-set 65

[ ! -f /etc/rc.local ] && echo -e "#!/bin/sh\nexit 0" > /etc/rc.local
chmod +x /etc/rc.local

grep -q 'TTL --ttl-set 65' /etc/rc.local || sed -i '/exit 0/i iptables -t mangle -A POSTROUTING -j TTL --ttl-set 65' /etc/rc.local

rm -- "$0"
