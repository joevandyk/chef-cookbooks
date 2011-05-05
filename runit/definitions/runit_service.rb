define :joe_service do
  include_recipe "runit"

  name      = params[:name]
  signal_on_update  ||= "hup"
  owner             = params[:owner]
  service_dir_name  = "/etc/sv/#{ name }"
  active_dir_name   = "/etc/service/#{name}"

  raise "must specify owner!" if ! owner

  # Create the runit service directory
  directory service_dir_name do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  # Make sure the owner owns everything in the runit service directory
  execute "chown #{ service_dir_name }" do
    command "chown -R #{ owner} #{ service_dir_name }"
  end

  # Create the runit log directory
  directory "#{service_dir_name}/log" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  # Create the environment directory
  directory "#{service_dir_name}/env" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  # Loop over the environment variables and create their files.
  if params[:env]
    params[:env].each do |env, value|
      file "#{service_dir_name}/env/#{env}" do
        content value
        owner params[:owner]
        group params[:group]
        notifies(:run, "execute[reload_runit_service_#{name}]")
      end
    end
  end

  # Create the actual log directory
  directory "/var/log/#{name}" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  # Restart the service whenever we change something.
  execute "reload_runit_service_#{name}" do
    command "service runsvdir reload; sleep 2; sv #{signal_on_update} #{name}"
    action :nothing
  end

  # Restart the service logger whenever we change something logging related.
  execute "restart_runit_log_#{ name}" do
    command "sv #{signal_on_update} #{name}/log"
    action :nothing
  end

  # Create the log configuration script.
  template "/var/log/#{name}/config" do
    owner params[:owner]
    group params[:group]
    source "log_config.erb"
    cookbook "runit"
    variables :service_name => name
    notifies(:run, "execute[restart_runit_log_#{name}]")
  end

  # Create the run script.
  template "#{service_dir_name}/run" do
    owner params[:owner]
    group params[:group]
    mode 0755
    source "run.erb"
    variables :command => params[:command],
              :user => params[:owner],
              :name => params[:name],
              :cwd => params[:cwd],
              :daemon => params[:daemon],
              :pid   => params[:pid]
    cookbook "runit"
    notifies(:run, "execute[reload_runit_service_#{name}]")
  end

  # Create the logging script.
  template "#{service_dir_name}/log/run" do
    cookbook "runit"
    owner params[:owner]
    group params[:group]
    mode 0755
    source "log.erb"
    variables :name => params[:name]
    notifies(:run, "execute[restart_runit_log_#{params[:name]}]")
  end

  # Activate the service by linking it to /etc/service..
  link active_dir_name do
    to service_dir_name
    owner params[:owner]
    group params[:group]
  end

  # Wait for runit to start.
  # Once it does, change ownership of service directory.
  # Dunno if it's possible to do this some other way
  ruby_block "supervise_#{params[:name]}_sleep" do
    block do
      Chef::Log.debug("Waiting until named pipe #{service_dir_name}/supervise/ok exists.")
      10.times { |i| sleep 1 unless ::FileTest.pipe?("#{service_dir_name}/supervise/ok") }
    end
    not_if { FileTest.pipe?("#{service_dir_name}/supervise/ok") }
    notifies :run, "execute[chown #{ service_dir_name }]"
  end

end

