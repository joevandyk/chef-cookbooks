
define :envdir do
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
