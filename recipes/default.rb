#
# Cookbook Name:: tourbuzz-samba
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#
yum_package 'sernet-samba' do
  action :install
end

template "/etc/default/sernet-samba" do
  source 'sernet-samba.erb'
	mode 0664
	owner "root"
	group "root"
end

template "/etc/samba/smb.conf" do
  source "smb.conf"
  mode 0664
  owner "root"
  group "root"
end

execute "Create smbpasswd user" do
  command "echo 'vagrant\nvagrant' | smbpasswd -s -a vagrant"
end

execute "Restart Samba" do
  %w(sernet-samba-nmbd sernet-samba-smbd).each do |cmd|
    command "service #{cmd} restart"
  end
end
