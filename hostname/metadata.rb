maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Ensures hostname is set correctly"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

%w{ ubuntu }.each do |os|
  supports os
end

attribute "node_hostname",
  :display_name => "Hostname of node",
  :description => "The desired hostname of the node"
