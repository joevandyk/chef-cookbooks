node[:env_vars].each do |user, options|
  options.each do |dir, vars|
    envdir do
      owner user
      env   vars
      dir   dir
    end
  end
end
