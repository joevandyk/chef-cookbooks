pkg_path = "/var/cache/apt/ruby-19.deb"

remote_file pkg_path do
  source   node[:ruby][:dpkg_url]
  checksum node[:ruby][:dpkg_sha]
end

dpkg_package "tanga-ruby19" do
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

file "/etc/gemrc" do
  content <<-EOF
gem: --no-ri --no-rdoc
  EOF
end

file "/etc/profile.d/path.sh" do
  mode "0444"
  content "export PATH=/opt/ruby19/bin:$PATH"
end

file "/etc/profile.d/ruby_gc.sh" do
  mode "0444"
  content ruby_gc_tweaks
end

