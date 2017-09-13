# use https://supermarket.chef.io/cookbooks/nodejs to install Node static server (https://github.com/nbluis/static-server)

include_recipe 'nodejs'

# Install package
nodejs_npm 'static-server'  # packages are installed globally by default

# Go to the folder you want to served

# Run the server
