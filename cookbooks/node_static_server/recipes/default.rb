# use https://supermarket.chef.io/cookbooks/nodejs to install Node static server (https://github.com/nbluis/static-server)

include_recipe 'nodejs'

# Install package
nodejs_npm 'pm2'

# Start server in the background, inside Chef's log directory (configured in Vagrantfile)
# FIXME Wrap static server in service to avoid running it in the background manually
# Also, a service can be restarted or stopped easily.
execute 'serve_logs_on_9090_as_daemon' do
  # command 'static-server --port 9090'  # works, http://192.168.50.4:9090/chef-solo.log
  # cwd '/var/log'
  command 'pm2 serve /var/log 9090'
end
