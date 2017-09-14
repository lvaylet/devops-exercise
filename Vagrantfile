# -*- mode: ruby -*-
# vi: set ft=ruby :

# References:
#   - https://stackoverflow.com/questions/19125374/how-do-i-configure-chef-solo-to-install-nginx-on-a-new-vagrant-box
#   - https://learn.chef.io/modules/learn-the-basics/ubuntu/virtualbox#/
#   - https://stackoverflow.com/questions/21150282/how-to-configure-nginx-with-chef-solo-on-vagrant
#   - https://www.vagrantup.com/docs/provisioning/chef_solo.html

Vagrant.configure("2") do |config|

  # Box details
  config.vm.box = "bento/ubuntu-14.04"  # "ubuntu/trusty64"

  # Plugins
  # ---
  # Enable and setup the Berkshelf and Omnibus plugins.
  config.berkshelf.enabled = true
  # *IMPORTANT*: the "apt_update" resource requires Chef 12.7+
  config.omnibus.chef_version = "12.7.2"

  # Network
  config.vm.hostname = "devops-exercise"
  config.vm.network "private_network", ip: "192.168.50.4"

  # Chef solo provisioning
  config.vm.provision :chef_solo do |chef|
    # Customize log location to serve it easily later on. Or symlink to it from a folder in $HOME?
    chef.arguments = "--logfile /var/log/chef-solo.log"  # --log_level debug"

    chef.cookbooks_path = "cookbooks"  # default value anyway, sample only

    # Define parameters for the recipes below
    chef.json = {
      "send_http_post" => {
        "endpoint" => "https://arterys.com/install-complete"
      }
    }

    # Run recipes
    chef.add_recipe "apt_update"
    chef.add_recipe "nodejs"
    chef.add_recipe "node_static_server"
    chef.add_recipe "nginx_ssl_auth"
    chef.add_recipe "send_http_post"
  end

end
