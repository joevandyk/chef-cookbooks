maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Installs/Configures RVM"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.6.0"

recipe "rvm",               "Includes all recipes"
recipe "rvm::system",       "Installs system-wide RVM"

%w{ debian ubuntu suse centos redhat fedora }.each do |os|
  supports os
end

attribute "rvm/default_ruby",
  :display_name => "Default ruby",
  :description => "The default ruby for RVM. If the RVM ruby is not installed, it will be built as a pre-requisite.",
  :default => "ruby-1.9.2-p180"

attribute "rvm/rubies",
  :display_name => "Installed RVM rubies",
  :description => "A list of RVM rubies to be built and installed. If this list is emptied then no rubies (not even the default) will be built and installed. The default is the an array containing the value of rvm/default_ruby.",
  :type => "array",
  :default => [ "node[:rvm][:default_ruby]" ]

attribute "rvm/global_gems",
  :display_name => "Global gems to be installed in all RVM rubies",
  :description => "A list of gem hashes to be installed into the *global* gemset in each installed RVM ruby. The RVM global.gems files will be added to and all installed rubies will be iterated over to ensure full installation coverage.",
  :type => "array",
  :default => [ { :name => "bundler" } ]

attribute "rvm/gems",
  :display_name => "Hash of ruby/gemset gem manifests",
  :description => "A list of gem hashes to be installed into arbitrary RVM rubies and gemsets.",
  :type => "hash",
  :default => Hash.new

attribute "rvm/rvmrc",
  :display_name => "Hash of rvmrc options",
  :description => "A hash of system-wide `rvmrc` options. The key is the RVM setting name (in String or Symbol form) and the value is the desired setting value. See RVM documentation for rvmrc options.",
  :type => "hash",
  :default => Hash.new

attribute "rvm/branch",
  :display_name => "A specific git branch to use when installing system-wide.",
  :description => "A specific git branch to use when installing system-wide.",
  :default => "nil"

attribute "rvm/version",
  :display_name => "A specific tagged version to use when installing system-wide.",
  :description => "A specific tagged version to use when installing system-wide. This value is passed directly to the `rvm-installer` script and current valid values are: `head` (the default, last git commit), `latest` (last tagged release version) and a specific tagged version of the form `1.2.3`. You may want to use a specific version of RVM to prevent differences in deployment from one day to the next (RVM head moves pretty darn quickly).",
  :default => "nil"

attribute "rvm/upgrade",
  :display_name => "How to handle updates to RVM framework",
  :description => "Determines how to handle installing updates to the RVM framework.",
  :default => "none"

attribute "rvm/root_path",
  :display_name => "RVM system-wide root path",
  :description => "Root path for system-wide RVM installation",
  :default => "/usr/local/rvm"

attribute "rvm/installer_url",
  :display_name => "The URL that provides the RVM installer.",
  :description => "The URL that provides the RVM installer.",
  :default => "http://rvm.beginrescueend.com/install/rvm"

attribute "rvm/group_users",
  :display_name => "Additional users in rvm group",
  :description => "Additional users in rvm group that can manage rvm in a system-wide installation.",
  :type => "array",
  :default => []
