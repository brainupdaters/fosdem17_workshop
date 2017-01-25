echo "Hello from $HOSTNAME at FOSDEM 2017"

echo "$(date) - Refreshing repositories ..."
sed -i "/ftp/s/.us./.be./g" /etc/apt/sources.list
apt-get update

echo "End of $HOSTNAME customization ..."
