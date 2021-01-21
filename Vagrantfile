#
# Juniper lab v0.1
#
# ge-0/0/0.0: management interface
# ge-0/0/1.0 - ge-0/0/7.0: user interfaces

#  NSO Topology
#  +---------+
#  |   nso   |
#  +---------+


Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
    vb.gui = false
  end
  config.vm.define 'nso' do |nso|
	  nso.vm.box = "ubuntu/focal64"
	  nso.vm.network :forwarded_port, guest: 22, host: 12202, id: 'ssh'
    nso.vm.network :forwarded_port, guest: 8080, host: 8080, id: 'nso'
	  # nso.vm.network "private_network", virtualbox__intnet: "ans_s01",
    #                 ip: "10.0.1.1",
    #                 netmask: "255.255.255.252",
		# 							  auto_config: true
    nso.vm.provision "file", source: "provision", destination: "provision"
	  nso.vm.provision 'shell', inline: <<-SHELL
      sleep 30
	    sudo /vagrant/install.sh
      SHELL
  end

end


