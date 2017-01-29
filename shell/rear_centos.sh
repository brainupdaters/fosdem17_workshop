echo "Hello from $HOSTNAME at FOSDEM 2017"

echo "$(date) - Adjusting Timezone ..."
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime

echo "$(date) - Restarting network service ..."
systemctl restart network

echo "$(date) - Refreshing repositories ..."
yum clean all
yum repolist

echo "End of $HOSTNAME customization ..."
