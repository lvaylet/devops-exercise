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
  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true
  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"
  config.omnibus.chef_version = "12.7.2"  # the "apt_pdate" resource requires 12.7+, and the "nginx" recipe generates a lot of errors with :latest (v13+)

  # Network
  config.vm.hostname = "devops-exercise"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.network :forwarded_port, guest: 9090, host: 9090
  #config.vm.network :forwarded_port, guest: 9090, host: 49800
  #config.vm.network :forwarded_port, guest: 80, host: 49880

  # Chef solo provisioning
  config.vm.provision :chef_solo do |chef|
    # Customize log location to serve it easily later on. Or symlink to it from a folder in $HOME?
    chef.arguments = "--logfile /var/log/chef-solo.log"  # --log_level debug"

    chef.cookbooks_path = "cookbooks"  # default value anyway, sample only

    #chef.add_recipe "apt"  # update list of packages first, to prevent 404 errors when retrieving it later on (when isntalling Nginx for example)
    #chef.add_recipe "nginx"  # install nginx
    #chef.json = {
    #  :nginx => {
    #    dir: "/etc/nginx"  # this is the default value, sample only
    #  }
    #}

    chef.add_recipe "apt_update"

    chef.add_recipe "nodejs"
    chef.add_recipe "node_static_server"

    chef.add_recipe "nginx_ssl_auth"
  end

end
