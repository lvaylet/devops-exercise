package 'nginx' do
  action :install
end

# Setup self-signed certificates in /etc/nginx
#
# Use headless mode, equivalent to typing the following in interactive mode:
#   Country Name (2 letter code) [AU]:FR
#   State or Province Name (full name) [Some-State]:IDF
#   Locality Name (eg, city) []:Paris
#   Organization Name (eg, company) [Internet Widgits Pty Ltd]:ACME
#   Organizational Unit Name (eg, section) []:
#   Common Name (eg, YOUR name) []:192.168.0.54
#   Email Address []:
#
# References:
#   - https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04
#   - https://superuser.com/questions/226192/avoid-password-prompt-for-keys-and-prompts-for-dn-information/1086972
execute 'generate_certs' do
  # Is 'sudo' required? Does chef-solo have root access?
  command 'sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 -new -subj "/C=US/ST=IDF/L=Paris/O=ACME/CN=192.168.50.4" -keyout ./cert.key -out ./cert.crt'
  cwd '/etc/nginx'
end

# Configure HTTP basic authentication
#
# References:
#   - https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04
file '/etc/nginx/.htpasswd' do
  content 'sammy:$apr1$74cZT6TZ$PmbFy2LAP3c4UP3a5PyEZ1'
end

# Render /etc/nginx/sites-available/default
template '/etc/nginx/sites-available/default' do
  source 'default.ssl_basic_auth.erb'
end

service 'nginx' do
  action :restart
end
