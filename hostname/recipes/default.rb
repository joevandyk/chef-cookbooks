template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
end

service "hostname" do
  provider Chef::Provider::Service::Upstart
  service_name "hostname"
end

template "/etc/hostname" do
  source "hostname.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, "service[hostname]", :immediately
end
