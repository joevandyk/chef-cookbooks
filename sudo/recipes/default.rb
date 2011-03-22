template "/etc/sudoers" do
  source "sudoers.erb"
  mode "0440"
end
