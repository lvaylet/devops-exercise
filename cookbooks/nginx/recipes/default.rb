package 'nginx' do
  action :install
end
# or simply:
# package 'nginx'
# as ':install' is the default action

service 'nginx' do
  supports status: true
  action [:enable, :start]
end

# Render index.html.erb to /usr/share/nginx/html/index.html (the default location served by Nginx)
template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
end
