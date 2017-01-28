# FOSDEM 2017 Workshop
> Disaster Recovery Management with ReaR and DRLM (Workshop instructions)


In this README you will find explained the required steps to prepare your own testing environment to follow the workshop and
play with ReaR and DRLM installation.

## Requirements

- Install Virtualbox and the extension pack from here: https://www.virtualbox.org/wiki/Downloads
- Install latest Vagrant software: https://www.vagrantup.com/downloads.html

## Configuration

### GNU/Linux & OS X:

Create 2 new Host-Only networks in your Virtualbox installation:

#### A. Using GUI:

1. Go to Preferences > Networks > Host-only Networks.

2a. Create a new network named vboxnet1, edit and set:

```sh
 IPv4 address: 10.100.0.254
 IPv4 Network Mask: 255.255.255.0
 Disable DHCP Server
```

2b. Create a new network named vboxnet2, edit and set:

```sh
 IPv4 address: 10.200.0.254
 IPv4 Network Mask: 255.255.255.0
 Disable DHCP Server
```

##### NOTE:
```sh
If Host-only network environment in your VBox installation is more complex, 
please create 2 new networks with the required configuration and adjust 
the Vagrantfile accordingly.
```

#### B. Using CLI:

1. List Host-only interfaces of your VBox installation:
```sh
$ VBoxManage list -l hostonlyifs
Name:            vboxnet0
GUID:            786f6276-656e-4074-8000-0a0027000000
DHCP:            Disabled
IPAddress:       192.168.56.1
NetworkMask:     255.255.255.0
IPV6Address:
IPV6NetworkMaskPrefixLength: 0
HardwareAddress: 0a:00:27:00:00:00
MediumType:      Ethernet
Status:          Down
VBoxNetworkName: HostInterfaceNetworking-vboxnet0
```
2a. If vboxnet0 is already present create vboxnet1 and vboxnet2 networks and configure them: 
```sh
$ VBoxManage hostonlyif create
$ VBoxManage hostonlyif create
$ VBoxManage hostonlyif ipconfig vboxnet1 --ip 10.100.0.254 --netmask 255.255.255.0
$ VBoxManage hostonlyif ipconfig vboxnet2 --ip 10.200.0.254 --netmask 255.255.255.0
```
2b. If vboxnet0 is not present create vboxnet0, vboxnet1 and vboxnet2 networks and configure last 2: 
```sh
$ VBoxManage hostonlyif create
$ VBoxManage hostonlyif create
$ VBoxManage hostonlyif create
$ VBoxManage hostonlyif ipconfig vboxnet1 --ip 10.100.0.254 --netmask 255.255.255.0
$ VBoxManage hostonlyif ipconfig vboxnet2 --ip 10.200.0.254 --netmask 255.255.255.0
```

### Windows:

For Microsoft Windows OS will be pretty the same configuration (GUI & CLI), but the VirtualBox networks will be named diferent:

- Host-Only Ethernet Adapter (vboxnet1)
- Host-Only Ethernet Adapter #2 (vboxnet2)

Note that there is no vboxnet0 in Windows and you must be in C:\Program files\Oracle\VirtualBox\ or adjust your PATH environment variable to run same VBox CLI commands.

##### NOTE:
```sh
If Host-only network environment in your VBox installation is more complex, 
please create 2 new networks with the required configuration and adjust 
the Vagrantfile accordingly. 
```

Now, we have all the requirements to prepare the workshop environment.

## Download all required vagrant boxes

- CentOS 7
- Debian 8
- Ubuntu 16.04
- OpenSUSE 42.1 (optional)

##### NOTE:
```sh
OpenSUSE 42.1 box is disabled by default because it is a huge box (1hour downloading approx.) 
If you want to use it please download the box before the workshop and uncomment it 
from the Vagrantfile. 
```

All boxes have the user "vagrant" with sudo privileges and password "vagrant". 

### GNU/Linux, OS X & Windows:

```sh   
$ vagrant box add https://atlas.hashicorp.com/minimal/boxes/centos7

$ vagrant box add https://atlas.hashicorp.com/minimal/boxes/jessie64

$ vagrant box add https://atlas.hashicorp.com/minimal/boxes/xenial64
```
###### OPTIONAL:
```sh 
$ vagrant box add https://atlas.hashicorp.com/opensuse/boxes/openSUSE-42.1-x86_64

   This box can work with multiple providers! The providers that it
   can work with are listed below. Please review the list and choose
   the provider you will be working with.

   1) libvirt
   2) virtualbox
   3) vmware_desktop

   Enter your choice: 2
```
Check if downloaded correctly:

```sh
$ vagrant box list
minimal/centos7  (virtualbox, 7.0)
minimal/jessie64 (virtualbox, 8.0)
minimal/xenial64 (virtualbox, 16.04.1)
opensuse/openSUSE-42.1-x86_64 (virtualbox, 1.0.0)
```

## Get the workshop from Github

### GNU/Linux, OS X & Windows:

#### Using GIT:
```sh
$ git clone https://github.com/brainupdaters/fosdem17_workshop
$ cd fosdem17_workshop
```
#### Download ZIP file from github (https://github.com/brainupdaters/fosdem17_workshop/archive/master.zip)
1. Uncompress.
2. Go to fosdem17_workshop folder.

Now, we have all the requirements to prepare the workshop environment.

## Start the environment

This takes about 10 minutes ...

### GNU/Linux, OS X & Windows:

```sh
$ vagrant up
```

## Suspend the environment

### GNU/Linux, OS X & Windows:

```sh
$ vagrant suspend
```

## Resume the environment

### GNU/Linux, OS X & Windows:

```sh
$ vagrant resume
```

## Destroy the environment

### GNU/Linux, OS X & Windows:

```sh
$ vagrant destroy -f
```
Previous command will keep downloaded boxes in your hard drive, 
just the VM's deployed with ```vagrant up``` will be destroyed.
If you do not need those boxes anymore, you can remove them:

```sh
$ vagrant box remove minimal/centos7
Removing box 'minimal/centos7' (v7.0) with provider 'virtualbox'...

$ vagrant box remove minimal/jessie64
Removing box 'minimal/jessie64' (v8.0) with provider 'virtualbox'...

$ vagrant box remove minimal/xenial64
Removing box 'minimal/xenial64' (v16.04.1) with provider 'virtualbox'...

$ vagrant box remove opensuse/openSUSE-42.1-x86_64
Removing box 'opensuse/openSUSE-42.1-x86_64' (v1.0.0) with provider 'virtualbox'...
```
As well, to clean up Virtualbox networks added for the workshop, do this:

### GNU/Linux & OS X:

```sh
$ VBoxManage hostonlyif remove vboxnet1
$ VBoxManage hostonlyif remove vboxnet2
```

### Windows:

```sh
C:\Program files\Oracle\VirtualBox\VBoxManage hostonlyif remove "Host-Only Ethernet Adapter"
C:\Program files\Oracle\VirtualBox\VBoxManage hostonlyif remove "Host-Only Ethernet Adapter #2"
```

##### NOTE:
```sh
If the network environment in your VBox installation is different, 
please remove added networks accordingly.
```

## Release History

* 1.0.2
    * CHANGE: Added Windows OS instructions. 
* 1.0.1
    * CHANGE: Improvements in destroy instructions. 
* 1.0.0
    * The first proper release
    * CHANGE: Ready for the workshop at FOSDEM'17
* 0.0.1
    * Work in progress

## Author

Didac Oliveira – [@didacog](https://twitter.com/didacog) – didac@brainupdaters.net

Distributed under the GPLv3 license. See ``LICENSE`` for more information.

[https://github.com/didacog](https://github.com/didacog/)

[https://www.linkedin.com/in/didacoliveiragarcia](https://www.linkedin.com/in/didacoliveiragarcia)
