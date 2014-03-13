#
# Cookbook Name:: gocd_agent
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# the default go user uses /var/go, we want /home/go
user "go" do
  action :create
  comment "go-agent user"
  uid 1000
  gid "users"
  home "/home/go"
  shell "/bin/sh"
  password "$1$uhNDPuBR$zCeyU3T/VlCKd46Widfhb."
  supports :manage_home => true
end

directory "/var/chef-package-cache" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/var/chef-package-cache/go-agent-13.4.1-18342.deb" do
  source "go-agent-13.4.1-18342.deb"
  owner "root"
  group "root"
  mode "0644"
end

package "go-agent" do
  provider Chef::Provider::Package::Dpkg
  source "/var/chef-package-cache/go-agent-13.4.1-18342.deb"
  action :install
end
