echo "Hello from $HOSTNAME at FOSDEM 2017"

echo "$(date) - Adjusting Timezone ..."
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
echo "Europe/Brussels" > /etc/timezone

echo "$(date) - Refreshing repositories ..."
sed -i "/ftp/s/.us./.be./g" /etc/apt/sources.list
apt-get update

echo "End of $HOSTNAME customization ..."
