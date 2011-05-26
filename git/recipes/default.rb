package "git-core"

if node[:git_checkouts]
  node[:git_checkouts].each do |path, options|
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
