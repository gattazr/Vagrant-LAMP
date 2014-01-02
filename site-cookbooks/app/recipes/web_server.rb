#
# Cookbook Name:: app
# Recipe:: web_server
#
# Copyright 2013, Rémi GATTAZ
#

# Install Apache
include_recipe "apache2"
include_recipe "apache2::mod_php5"

# Install php
include_recipe "dotdeb"
include_recipe "dotdeb::php54"

# create apache config
template "#{node['apache']['dir']}/sites-available/#{node['app']['name']}.conf" do
	source 'web_app.conf.erb'
	notifies :restart, 'service[apache2]'
end

# enable website
apache_site "#{node['app']['name']}.conf" do
	enable true
end