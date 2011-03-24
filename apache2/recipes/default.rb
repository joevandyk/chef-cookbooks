#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "apache2" do
  package_name "apache2"
  action :install
end

service "apache2" do
  service_name "apache2"
  restart_command "/usr/sbin/invoke-rc.d apache2 restart && sleep 1"
  reload_command "/usr/sbin/invoke-rc.d apache2 reload && sleep 1"
  supports [:restart, :reload, :status]
  action :enable
end

# Restart apache if the service is installed and rubygems is updated.
service "apache2" do
  only_if do
    File.exist?("/etc/init.d/apache2")
  end
  subscribes :restart, resources(:execute => "update_rubygems"), :immediately
end

directory "#{node[:apache][:dir]}/ssl" do
  action :create
  mode 0755
  owner "root"
  group "root"
end

template "apache2.conf" do
  path "#{node[:apache][:dir]}/apache2.conf"
  source "apache2.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2")
end

template "security" do
  path "#{node[:apache][:dir]}/conf.d/security"
  source "security.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :restart, resources(:service => "apache2")
end

template "charset" do
  path "#{node[:apache][:dir]}/conf.d/charset"
  source "charset.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
  notifies :restart, resources(:service => "apache2")
end

template "#{node[:apache][:dir]}/ports.conf" do
  source "ports.conf.erb"
  group "root"
  owner "root"
  variables :apache_listen_ports => node[:apache][:listen_ports]
  mode 0644
  notifies :restart, resources(:service => "apache2")
end

template "#{node[:apache][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2")
end

include_recipe "apache2::mod_status"
include_recipe "apache2::mod_alias"
include_recipe "apache2::mod_auth_basic"
include_recipe "apache2::mod_authn_file"
include_recipe "apache2::mod_authz_default"
include_recipe "apache2::mod_authz_groupfile"
include_recipe "apache2::mod_authz_host"
include_recipe "apache2::mod_authz_user"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_autoindex"
include_recipe "apache2::mod_dir"
include_recipe "apache2::mod_env"
include_recipe "apache2::mod_mime"
include_recipe "apache2::mod_negotiation"
include_recipe "apache2::mod_setenvif"
include_recipe "apache2::mod_log_config" if platform?("centos", "redhat", "suse")

# uncomment to get working example site on centos/redhat/fedora
#apache_site "default"

service "apache2" do
  action :start
end
