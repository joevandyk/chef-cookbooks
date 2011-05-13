define :envdir do
  package "daemontools"

  directory "/etc/env" do
    mode 0755
  end

  directory "/env" do
    mode 0755
  end

  dir = "/etc/env/#{params[:dir]}"

  directory dir do
    owner params[:owner]
    mode 0700
  end

  params[:env].each do |env_name, value|
    file "#{dir}/#{env_name}" do
      content value
      owner params[:owner]
      mode 0600
    end
  end
end
