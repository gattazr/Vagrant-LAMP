#
# Cookbook Name:: app
# Recipe:: database
#
# Copyright 2013, Rémi GATTAZ
#
include_recipe 'mysql'
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = {
	:host		=>	node['mysql']['host'],
	:username	=>	'root',
	:password	=>	node['mysql']['server_root_password']
}

mysql_database node['app']['database_name'] do
	connection	mysql_connection_info
	action		:create
end

mysql_database_user node['app']['database_user'] do
	connection		mysql_connection_info
	password		node['app']['database_password']
	database_name	node['app']['database_name']
	host			node['mysql']['host']
	privileges		[:all]
	action			[:create, :grant]
end
