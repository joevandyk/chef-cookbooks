default[:ruby][:install_path] = "/opt/ruby19"
default[:ruby][:ruby_bin]     = "/opt/ruby19/bin/ruby"
default[:ruby][:gem_bin]      = "#{ruby[:install_path]}/bin/gem"
default[:ruby][:gems_dir]     = "#{ruby[:install_path]}/lib/ruby/gems/1.9.1"
default[:ruby][:version]      = '1.9.2-p180'
default[:languages][:ruby][:ruby_bin] = "/opt/ruby19/bin/ruby"
default[:languages][:ruby][:gems_dir] = "#{ruby[:install_path]}/lib/ruby/gems/1.9.1"

case node.automatic[:kernel][:machine]
when "i686"
  default[:ruby][:dpkg_url] = "https://s3.amazonaws.com/tanga/tanga-ruby19_1.0.1_i386.deb"
  default[:ruby][:dpkg_sha] = "3c20dc1000783cd3bd04925e5a60f3eee3c0d5a2650f4ef1a981f4b46d00d5c7"
when "x86_64"
  raise "not done yet"
else
  raise "what are you??"
end
