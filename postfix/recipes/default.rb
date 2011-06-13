#
# Author:: Joshua Timberman(<joshua@opscode.com>)
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

%w{ postfix libsasl2-2  ca-certificates}.each do |pkg|
  package pkg do
    action :install
  end
end

service "postfix" do
  action :enable
end

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "postfix")
end

execute "postmap-relayhost_map" do
  command "postmap /etc/postfix/relayhost_map"
  action :nothing
end

execute "postmap-sasl_passwd" do
  command "postmap /etc/postfix/sender_sasl"
  action :nothing
end

template "/etc/postfix/relayhost_map" do
  source "relayhost_map.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, resources(:execute => "postmap-relayhost_map"), :immediately
  notifies :restart, resources(:service => "postfix")
end

template "/etc/postfix/sender_sasl" do
  source "sender_sasl.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, resources(:execute => "postmap-sasl_passwd"), :immediately
  notifies :restart, resources(:service => "postfix")
end

