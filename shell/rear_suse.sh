echo "Hello from $HOSTNAME at FOSDEM 2017"

#echo "Accepting EULA ..."
#touch /home/vagrant/.eula-accepted

echo "$(date) - Refreshing repositories ..."
zypper rr systemsmanagement-chef
zypper rr systemsmanagement-puppet
zypper refresh

echo "End of $HOSTNAME customization ..."
