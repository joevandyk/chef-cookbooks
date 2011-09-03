service "ssh" do
  supports :restart => true, :reload => true
  action :enable
end

template "/etc/ssh/ssh_config" do
  source "ssh_config"
  notifies :reload, resources(:service => 'ssh')
  mode "0644"
end

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  notifies :reload, resources(:service => 'ssh')
  mode "0644"
end

=begin
iptables_allow_tcp_port "ssh" do
  port 22
end
=end
