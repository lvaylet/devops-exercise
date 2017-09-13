package 'apache2'

service 'apache2' do
  supports status: true
  action [:enable, :start]
end

# Render index.html.erb to /var/www/html/index.html (the default location served by Apache)
template '/var/www/html/index.html' do
  source 'index.html.erb'
end
