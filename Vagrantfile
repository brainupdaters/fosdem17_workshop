domain   = 'drlm.org'

nodes = [

# ReaR clients

  { :hostname => 'rear-centos', :fport => 22210 , :ip => '10.100.0.10', :mac => '080027010010', :net => 'vboxnet1', :nic => 2 , :box => 'minimal/centos7', :ram => 512 , :script => 'shell/rear_centos.sh' },
  # OpenSUSE box is huge and its download will take 1h aprox. Is disabled by default.
  #{ :hostname => 'rear-suse', :fport => 22211 , :ip => '10.200.0.11', :mac => '080027010011', :net => 'vboxnet2', :nic => 2 , :box => 'opensuse/openSUSE-42.1-x86_64', :ram => 512 , :script => 'shell/rear_suse.sh' },
  { :hostname => 'rear-ubuntu', :fport => 22212 , :ip => '10.200.0.12', :mac => '080027010012', :net => 'vboxnet2', :nic => 2 , :box => 'minimal/xenial64', :ram => 512 , :script => 'shell/rear_ubuntu.sh' },
  { :hostname => 'rear-debian', :fport => 22213 , :ip => '10.100.0.13', :mac => '080027010013', :net => 'vboxnet1', :nic => 2 , :box => 'minimal/jessie64', :ram => 512 , :script => 'shell/rear_debian.sh' },

# DRLM servers

  { :hostname => 'drlm-ubuntu', :fport => 22250 , :ip => '10.100.0.50', :mac => '080027010050', :net => 'vboxnet1', :nic =>  2 , :ip2 => '10.200.0.50', :mac2 => '080027020050', :net2 => 'vboxnet2', :nic2 => 3 , :box => 'minimal/xenial64', :ram => 512 , :script => 'shell/drlm_ubuntu.sh' },
  { :hostname => 'drlm-debian', :fport => 22260 , :ip => '10.100.0.60', :mac => '080027010060', :net => 'vboxnet1', :nic =>  2 , :ip2 => '10.200.0.60', :mac2 => '080027020060', :net2 => 'vboxnet2', :nic2 => 3 , :box => 'minimal/jessie64', :ram => 512 , :script => 'shell/drlm_debian.sh' },

]

# Deployment of the Workshop enviroment

Vagrant.configure("2") do |config|
  
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.boot_timeout = 480
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      # Disable Shared Folders, we're not using them.
      nodeconfig.vm.synced_folder ".", "/vagrant", :disabled => true    
      nodeconfig.vm.network :forwarded_port, guest: 22, host: node[:fport], id: 'ssh' 
      nodeconfig.vm.network "private_network", ip: node[:ip], :mac => node[:mac], :name => node[:net], :adapter => node[:nic]

      if !(node[:ip2].nil?) || !(node[:net2].nil?) || !(node[:nic2].nil?) 
        nodeconfig.vm.network "private_network", ip: node[:ip2], :mac => node[:mac2], :name => node[:net2], :adapter => node[:nic2]
      end

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
	vb.name = node[:hostname]
      	vb.gui = false
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
	  "--usb", "off",
	  "--usbehci", "off",
        ]
      end
    end
  end

  nodes.each do |node|
  	config.vm.define node[:hostname] do |nodeconfig|
  	  nodeconfig.vm.provision "shell", path: node[:script]
  	end
  end
end
