include_recipe 'chef_nginx'

# FIXME How to handle keyboard input for the certificate settings?
# https://superuser.com/questions/226192/avoid-password-prompt-for-keys-and-prompts-for-dn-information/1086972
#execute 'generate_certs' do
#  # Is 'sudo' required? Does chef-solo have root access?
#  command 'sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./cert.key -out ./cert.crt'
#  command 'sudo openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout www.example.com.key -out www.example.com.cert'
#  cwd '/etc/nginx'
#end

# Configure HTTP basic authentication
# https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04
# Create /etc/nginx/.htpasswd
file '/etc/nginx/.htpasswd' do
  content 'sammy:$apr1$74cZT6TZ$PmbFy2LAP3c4UP3a5PyEZ1'
end

# Render /etc/nginx/sites-available/default
template '/etc/nginx/sites-available/default' do
  source 'default.basic_auth.erb'
end

# Render /usr/share/nginx/html/index.html (the default location served by Apache)
template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
end

service 'nginx' do
  action :restart
end
