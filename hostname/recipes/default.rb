
node[:short_hostname] = node[:node_hostname].split('.').first


execute "restart_hostname" do
  command "/etc/init.d/hostname restart"
  action :nothing
end

template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, resources(:execute => :restart_hostname)
end

template "/etc/hostname" do
  source "hostname.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :run, resources(:execute => :restart_hostname), :immediately
end
