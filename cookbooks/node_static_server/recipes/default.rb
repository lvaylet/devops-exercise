# Install pm2 globally
nodejs_npm 'pm2'

# Serve Chef's log directory with pm2
# FIXME I could not get static-server to work, and most forums recommend using pm2 anyway
execute 'serve_logs_on_9090_as_daemon' do
  # command 'static-server --port 9090'  # works, http://192.168.50.4:9090/chef-solo.log
  # cwd '/var/log'
  command 'pm2 serve /var/log 9090'
end
