version = "ruby-2.0.0-p247"
package "stow"

pkg_path = "/var/cache/apt/#{version}-i386.tar.bz2"

remote_file pkg_path do
  source "https://s3.amazonaws.com/tanga/production/#{version}-i386.tar.bz2"
  action :create_if_missing
end

execute "tar jxf #{pkg_path} && sudo stow -D ruby* && sudo stow #{version}" do
  cwd "/usr/local/stow"
  creates "/usr/local/stow/#{version}"
end
