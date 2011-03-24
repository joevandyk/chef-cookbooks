template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/hostname" do
  source "hostname.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end
