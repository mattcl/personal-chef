#
# Cookbook Name:: gocd_server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "unzip" do
  action :install
end

directory "/var/chef-package-cache" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/var/chef-package-cache/go-server-13.4.1-18342.deb" do
  source "go-server-13.4.1-18342.deb"
  owner "root"
  group "root"
  mode "0644"
end

package "go-server" do
  provider Chef::Provider::Package::Dpkg
  source "/var/chef-package-cache/go-server-13.4.1-18342.deb"
  action :install
end
