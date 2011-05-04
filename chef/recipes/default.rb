include_recipe "apt"

# Install opscode apt gpg key, rerun apt-get update, install specified version of chef.

key_file = "#{Chef::Config.file_cache_path}/opscode.key"
cookbook_file key_file
execute "add_opscode_apt_key" do
  command "apt-key add #{ key_file }"
  notifies :run, resources(:execute => "apt-get update"), :immediately
  action :nothing
end

execute "halt" do
  action :nothing
  command "echo 'You need to rerun chef (it was just upgarded)'; exit -1"
end


file "/etc/apt/sources.list.d/opscode.list" do
  content <<-EOF
deb     http://apt.opscode.com/ lucid main
deb-src http://apt.opscode.com/ lucid main
  EOF
  notifies :run, resources(:execute => "add_opscode_apt_key"), :immediately
end

package "chef" do
  #version "0.9.14+dfsg-1"
  action :install
  notifies(:run, resources(:execute => "halt"), :immediately)
end

service "chef-client" do
  action [:stop, :disable]
end
