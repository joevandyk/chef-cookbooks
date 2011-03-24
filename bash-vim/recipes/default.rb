cookbook_file "/etc/profile.d/bash-vim.sh" do
  mode 0644
end

cookbook_file "/etc/profile.d/good_prompt.sh" do
  mode 0644
end

cookbook_file "/etc/profile" do
  mode 0644
end
