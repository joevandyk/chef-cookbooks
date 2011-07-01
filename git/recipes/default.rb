package "git-core"

if node[:git_checkouts]
  node[:git_checkouts].each do |path, options|
    execute "chown -R #{ options[:user] } /tmp/ssh*" # Let us do ssh forwarding in forked programs
    directory path do
      owner options[:user]
      recursive true
    end
    git path do
      repository options[:git]
      reference  options[:branch]
      action     :checkout
      user       options[:user]
    end
  end
end

# git bash completion
link "/etc/profile.d/git.sh" do
  to "/etc/bash_completion.d/git"
end
