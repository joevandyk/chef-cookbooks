node.users.each do |username, options|
  home_dir = "/home/#{username}"

  # In case it doesn't exist yet
  group "admin"

  user username do
    group "admin"
    home home_dir
    shell "/bin/bash"
  end
  group username
  directory home_dir do
    owner username
  end
  directory "#{home_dir}/.ssh" do
    owner username
    mode "0700"
  end
  file "#{home_dir}/.ssh/authorized_keys" do
    content options["ssh_authorized_keys"].join("\n")
    mode "0600"
    owner username
  end
  file "#{home_dir}/.bashrc" do
    content "export PATH=/opt/ruby19/bin:$PATH"
    mode "0600"
    owner username
  end

  file "#{home_dir}/.bashrc" do
    content "export PATH=/opt/ruby19/bin:$PATH"
    mode "0600"
    owner username
  end
end
