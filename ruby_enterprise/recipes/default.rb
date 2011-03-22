pkg_path = "#{Chef::Config[:file_cache_path]}/ruby-enterprise.dpkg"

remote_file pkg_path do
  source   node[:ruby_enterprise][:dpkg_url]
  checksum node[:ruby_enterprise][:dpkg_sha]
end

dpkg_package "ruby-enterprise" do
  source pkg_path
end

# GC tweaks
ruby_gc_tweaks = <<-TWEAKS
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
TWEAKS

file "/usr/local/bin/ruby_gc" do
  mode "0755"
  content <<-EOF
#!/bin/sh
#{ ruby_gc_tweaks }
exec "/usr/local/bin/ruby" "$@"
  EOF
end

file "/etc/profile.d/ruby_gc.sh" do
  mode "0444"
  content ruby_gc_tweaks
end

cookbook_file "/usr/local/lib/ruby/1.8/pathname.rb" do
  mode "0755"
end

# ensure latest rubygem
rubygem_version = "1.6.2"
ree_gem "rubygems-update" do
  version rubygem_version
end

execute "update_rubygems" do
  action :run
  only_if do
    `gem --version`.strip != rubygem_version
  end
end

