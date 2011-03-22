default[:ruby_enterprise][:install_path] = "/usr/local"
default[:ruby_enterprise][:ruby_bin]     = "/usr/local/bin/ruby"
default[:ruby_enterprise][:gems_dir]     = "#{ruby_enterprise[:install_path]}/lib/ruby/gems/1.8"
default[:ruby_enterprise][:version]      = '1.8.7-2010.02'
default[:ruby_enterprise][:dpkg_url]     = "http://fixieconsulting.com/ruby-enterprise_#{node[:ruby_enterprise][:version]}.deb"
default[:ruby_enterprise][:dpkg_sha]     = "d65d3491fac28"

default[:languages][:ruby][:ruby_bin] = "/usr/local/bin/ruby"
default[:languages][:ruby][:gems_dir] = "#{ruby_enterprise[:install_path]}/lib/ruby/gems/1.8"
