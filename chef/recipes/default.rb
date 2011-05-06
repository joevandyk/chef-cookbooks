include_recipe "chef-rvm"
package "build-essential"

execute "halt" do
  action :nothing
  command "echo 'You need to rerun chef (it was just upgarded)'; exit -1"
end

rvm_gem "chef" do
  version "0.10.0"
  notifies(:run, resources(:execute => "halt"), :immediately)
end

service "chef-client" do
  action [:stop, :disable]
end
