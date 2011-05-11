
# NodeJS
node_file = "/var/cache/apt/node.deb"
remote_file node_file do
  source   "https://s3.amazonaws.com/tanga/node_v0.4.2-1_i386.deb"
  checksum "c407e54d861ec844eda518b4bdd0b065c90726f3acd90f0271889b691577aeb7"
end
dpkg_package "node" do
  version "0.4.2"
  source node_file
end

# Coffeescript
coffee_file = "/var/cache/apt/coffee.deb"
remote_file coffee_file do
  source "https://s3.amazonaws.com/tanga/coffee-script_1.1.0-1_i386.deb"
  checksum "0b56028e52844ae86874dfb8b8b7a136a39d06e80b176d916d6c0c98e0204fe9"
end
dpkg_package "coffee-script" do
  version "1.1.0"
  source coffee_file
end
