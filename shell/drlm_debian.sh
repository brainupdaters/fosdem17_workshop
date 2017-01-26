echo "Hello from $HOSTNAME at FOSDEM 2017"

cd /
echo "$(date) - Starting DRLM Provisioning ..."
echo "$(date) - Installing DRLM deps ..."
sed -i "/ftp/s/.us./.be./g" /etc/apt/sources.list
apt-get update
apt-get -y install openssh-client openssl wget gzip tar gawk sed grep coreutils util-linux nfs-kernel-server rpcbind isc-dhcp-server tftpd-hpa syslinux apache2 qemu-utils sqlite3
apt-get -y install lsb-release

echo "$(date) - Installing Build deps ..."
apt-get -y install git build-essential debhelper

echo "$(date) - Getting DRLM from source ..."
git clone https://github.com/brainupdaters/drlm
cd drlm

echo "$(date) - Building DRLM ..."
make deb
cd ..

echo "$(date) - Installing DRLM ..."
dpkg -i drlm_2.0.0_all.deb

echo "$(date) - Configuring loop limits ..."
sed -i "/GRUB_CMDLINE_LINUX=/s/\"\"/\"max_loop=1024\"/g" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "$(date) - Configuring TFTP service for DRLM ..."
sed -i "/TFTP_DIRECTORY=/s/\"\/srv\/tftp\"/\"\/var\/lib\/drlm\/store\"/g" /etc/default/tftpd-hpa

echo "$(date) - Configuring HTTP service for DRLM ..."
a2enmod ssl
a2enmod rewrite
a2enmod cgi
echo "# Include the DRLM Configuration:" | tee -a /etc/apache2/apache2.conf
echo "Include /usr/share/drlm/conf/HTTP/https.conf" | tee -a /etc/apache2/apache2.conf
rm -v /etc/apache2/sites-enabled/*
sed -i "s/Listen 80/#Listen 80/g" /etc/apache2/ports.conf

echo "$(date) - Restarting & checking services ..."
systemctl restart tftpd-hpa.service
systemctl status tftpd-hpa.service
systemctl restart rpcbind.service
systemctl status rpcbind.service
systemctl restart apache2.service
systemctl status apache2.service

echo "$(date) - Rebooting system to apply changes ..."
nohup reboot > /dev/null 2>&1 &

echo "End of $HOSTNAME customization ..."
