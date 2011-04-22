default[:ruby_enterprise][:install_path] = "/usr/local"
default[:ruby_enterprise][:ruby_bin]     = "/usr/local/bin/ruby"
default[:ruby_enterprise][:gems_dir]     = "#{ruby_enterprise[:install_path]}/lib/ruby/gems/1.8"
default[:ruby_enterprise][:version]      = '1.8.7-2011.03'
default[:languages][:ruby][:ruby_bin] = "/usr/local/bin/ruby"
default[:languages][:ruby][:gems_dir] = "#{ruby_enterprise[:install_path]}/lib/ruby/gems/1.8"

case node.automatic[:kernel][:machine]
when "i686"
  default[:ruby_enterprise][:dpkg_url] = "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_#{node[:ruby_enterprise][:version]}_i386_ubuntu10.04.deb"
  default[:ruby_enterprise][:dpkg_sha] = "c9a78784f8915dd3e7e0ff7aa09685564f16b8e6c4e8faaf51a7898476b2a504"
when "x86_64"
  default[:ruby_enterprise][:dpkg_url] = "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_#{node[:ruby_enterprise][:version]}_amd64_ubuntu10.04.deb"
  default[:ruby_enterprise][:dpkg_sha] = "1c5f5d5ef1efb497ee9aec4b1ce6bc56803f7046c2d75d220c67ae786769cd62"
else
  raise "what are you??"
end
