include_recipe 'chef_nginx'

# FIXME How to handle keyboard input for the certificate settings?
execute 'generate_certs' do
  # Is 'sudo' required? Does chef-solo have root access?
  command 'sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./cert.key -out ./cert.crt'
  cwd '/etc/nginx'
end

# Render default.erb to /etc/nginx/sites-enabled/default
template '/etc/nginx/sites-enabled/default' do
  source 'default.erb'
end

service 'nginx' do
  action :restart
end
