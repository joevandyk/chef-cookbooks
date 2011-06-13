default[:ruby][:install_path] = "/opt/ruby19"
default[:ruby][:ruby_bin]     = "/opt/ruby19/bin/ruby"
default[:ruby][:gems_dir]     = "#{ruby[:install_path]}/lib/ruby/gems/1.9.1"
default[:ruby][:version]      = '1.9.2-p180'
default[:languages][:ruby][:ruby_bin] = "/opt/ruby19/bin/ruby"
default[:languages][:ruby][:gems_dir] = "#{ruby[:install_path]}/lib/ruby/gems/1.9.1"

case node.automatic[:kernel][:machine]
when "i686"
  default[:ruby][:dpkg_url] = "https://s3.amazonaws.com/tanga/tanga-ruby19_1.0.0_i386.deb"
  default[:ruby][:dpkg_sha] = "fabee1b2316f2eef308a5cb3fca588190610862d10981d5841963dfe995c73e0"
when "x86_64"
  raise "not done yet"
else
  raise "what are you??"
end
