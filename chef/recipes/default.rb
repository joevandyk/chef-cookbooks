=begin
include_recipe "ruby_enterprise"
package "build-essential"

execute "halt" do
  action :nothing
  command "echo 'You need to rerun chef (it was just upgarded)'; exit -1"
end

ree_gem "chef" do
  version "0.10.0"
  notifies(:run, resources(:execute => "halt"), :immediately)
end

service "chef-client" do
  action [:stop, :disable]
end
=end
