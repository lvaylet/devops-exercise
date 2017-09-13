# use https://supermarket.chef.io/cookbooks/nodejs to install Node static server (https://github.com/nbluis/static-server)

include_recipe 'nodejs'

# Install package
nodejs_npm 'static-server'  # packages are installed globally by default

# Start server in Chef's log directory
execute 'run_static_server' do
  command 'static-server --port 9090'
  cwd '/var/log'
end
