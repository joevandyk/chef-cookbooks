define :add_ubuntu_ppa do
  execute "Add PPA key" do
    command "add-apt-repository #{params[:name]}"
    not_if "dpkg -l #{params[:provides_package]}"
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end
