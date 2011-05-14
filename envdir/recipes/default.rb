package "daemontools"

directory "/etc/env" do
  mode 0755
end

directory "/env" do
  mode 0755
end

node[:env_vars].each do |user, options|
  options.each do |dir, vars|
    envdir do
      owner user
      env   vars
      dir   dir
    end
  end
end
