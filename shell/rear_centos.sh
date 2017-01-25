echo "Hello from $HOSTNAME at FOSDEM 2017"

echo "Restarting network service ..."
systemctl restart network

echo "$(date) - Refreshing repositories ..."
yum clean all
yum repolist

echo "End of $HOSTNAME customization ..."
