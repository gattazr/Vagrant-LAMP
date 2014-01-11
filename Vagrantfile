# -*- mode: ruby -*-
# vi: set ft=ruby :

# General configuration
#######################
ip_address = '33.33.33.10'
project_name = 'myAwesomeProject'
src_path = '/var/www/public/'
mysql_password = 'root'
database_name = 'database_name'
database_user = 'database_user'
database_password = 'database_password'

php_packages = %w{ php5-mysqlnd php5-xdebug }

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# All Vagrant configuration is done here.

	# Enable Berkshelf support
	config.berkshelf.enabled = true

	# Define the VM box to use.
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# make sure omnibus is up to date
	config.omnibus.chef_version = :latest

	# set virtualbox configuration
	config.vm.provider :virtualbox do |vb|
		vb.name = "Vagrant-"+ project_name
	end
	config.vm.boot_timeout = 120


	# Manage the adress and hostname of the VM
	config.vm.network :private_network, ip: ip_address
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.vm.define project_name do |node|
		node.vm.hostname = project_name + ".dev"
		node.vm.network :private_network, ip: ip_address
		node.hostmanager.aliases = [ "www." + project_name + ".dev" ]
	end
	config.vm.provision :hostmanager

	# set the shared folder
	config.vm.synced_folder "./public/" , src_path, :mount_options => ["dmode=777", "fmode=666"]

	# update the apt repository
	config.vm.provision :shell, :inline => "apt-get update -qq"
	
	# Enable and configure chef solo
	config.vm.provision :chef_solo do |chef|
		chef.add_recipe "app::web_server"
		chef.add_recipe "app::database"

		chef.json = {
			:app => {
				:name => project_name,
				:src_path => src_path,

				:server_name    => project_name + ".dev",
				:server_aliases =>  [ "www." + project_name + ".dev" ],
				:server_address => ip_address,

				:database_name => database_name,
				:database_user => database_user,
				:database_password => database_password,

				:php_packages => php_packages
			},
			:mysql => {
				:host => 'localhost',
				:server_root_password 	=> mysql_password,
				:server_repl_password 	=> mysql_password,
				:server_debian_password	=> mysql_password,
				:bind_address 			=> ip_address,
				:allow_remote_root 		=> true
			}
		}
	end

end
