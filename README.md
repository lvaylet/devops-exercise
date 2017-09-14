# DevOps Exercise

> Use `chef-solo` to develop an automated deployment and configuration system

Chef-solo is used to complete the following tasks:
- Deploy `node-static`, a free static web server available from `npm`, which is run by using `node.js`.
- Configure the webserver to serve only a single file by default, the chef-solo installation log that is a result of the installation.
- Install and configure Nginx with access through "https" with "http basic authentication".
- Issue an http post to a given endpoint, easily
configured when executing the chef script (e.g. https://arterys.com/install-complete). It should not
post if the endpoint is not configured when the script is run.

# Prerequisites
- [Vagrant 1.9.8 (any 1.X should work too, but NOT 2.0 as Berkshelf plugin is not compatible at the time of writing)](https://releases.hashicorp.com/vagrant/1.9.8/)
- [Chef Development Kit (ChefDK)](https://downloads.chef.io/chefdk)

# Installation

```bash
# Clone repo
git clone https://github.com/lvaylet/devops-exercise

cd devops-exercise

# Install Vagrant plugins
# ---
# Berkshelf is a tool for managing cookbook dependencies (i.e. Chef's dependency management system).
vagrant plugin install vagrant-berkshelf
# Omnibus can install any version of Chef or ensure we're using the latest one.
vagrant plugin install vagrant-omnibus
```

# Usage

```bash
vagrant up

# Display Chef log
curl -X GET --user sammy:pass http://192.168.50.4

# Gracefully shut down the VM
vagrant halt
```
