define :joe_service do
  include_recipe "runit"

  name      = params[:name]
  signal_on_update  ||= "hup"
  owner             = params[:owner]
  service_dir_name  = "/etc/sv/#{ name }"
  active_dir_name   = "/etc/service/#{name}"

  raise "must specify owner!" if ! owner

  directory service_dir_name do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  execute "chown #{ service_dir_name }" do
    command "chown -R #{ owner} #{ service_dir_name }"
  end

  directory "#{service_dir_name}/log" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  directory "#{service_dir_name}/env" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end
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


  directory "/var/log/#{name}" do
    owner params[:owner]
    group params[:group]
    mode 0755
    action :create
  end

  execute "reload_runit_service_#{name}" do
    command "sv #{signal_on_update} #{name}"
    action :nothing
  end

  execute "restart_runit_log_#{ name}" do
    command "sv #{signal_on_update} #{name}/log"
    action :nothing
  end

  template "/var/log/#{name}/config" do
    owner params[:owner]
    group params[:group]
    source "log_config.erb"
    cookbook "runit"
    variables :service_name => name
    notifies(:run, "execute[restart_runit_log_#{name}]")
  end


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

  template "#{service_dir_name}/log/run" do
    cookbook "runit"
    owner params[:owner]
    group params[:group]
    mode 0755
    source "log.erb"
    variables :name => params[:name]
    notifies(:run, "execute[restart_runit_log_#{params[:name]}]")
  end

  link active_dir_name do
    to service_dir_name
    owner params[:owner]
    group params[:group]
  end

  ruby_block "supervise_#{params[:name]}_sleep" do
    block do
      Chef::Log.debug("Waiting until named pipe #{service_dir_name}/supervise/ok exists.")
      (1..10).each {|i| sleep 1 unless ::FileTest.pipe?("#{service_dir_name}/supervise/ok") }
    end
    not_if { FileTest.pipe?("#{service_dir_name}/supervise/ok") }
    notifies :run, "execute[chown #{ service_dir_name }]"
  end

end

