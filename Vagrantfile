# -*- mode: ruby -*-
# vi: set ft=ruby :

# General configuration
#######################
ip_adress = '33.33.33.10'
project_name = 'myAwesomeProject'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# All Vagrant configuration is done here. The most common configuration
	# options are documented and commented below. For a complete reference,
	# please see the online documentation at vagrantup.com.

	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	config.omnibus.chef_version = :latest
	config.vm.network :private_network, ip: "33.33.33.10"
	config.vm.boot_timeout = 120
	config.berkshelf.enabled = true

	config.vm.provider :virtualbox do |vb|
		vb.name = "Vagrant-"+ project_name
	end

	config.vm.provision :chef_solo do |chef|
      chef.add_recipe "app::web_server"
  end

end
