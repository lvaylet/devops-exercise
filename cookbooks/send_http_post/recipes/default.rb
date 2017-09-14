# References:
#  - https://docs.chef.io/resource_http_request.html

# Pull parameter from Vagrantfile
endpoint = node['send_http_post']['endpoint']

if endpoint
  log 'notifying endpoint' do
    message 'Sending POST request to endpoint: ' + endpoint
    level :info
  end

  http_request 'send_http_post' do
    url endpoint
    action :post
  end
else
  log 'no_endpoint_defined' do
    message 'Please define an endpoint in your Vagrantfile to be notified of provisioning success.'
    level :warn
  end
end
