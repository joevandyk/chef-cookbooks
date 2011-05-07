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
exec "/usr/local/rvm/gems/ree-1.8.7-2011.03" "$@"
  EOF
end

file "/etc/profile.d/ruby_gc.sh" do
  mode "0444"
  content ruby_gc_tweaks
end
