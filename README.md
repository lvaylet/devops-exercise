# DevOps Exercise

> Description

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

# Browse Chef log
curl -X GET 'https://localhost:49800'

# Gracefully shut down the VM
vagrant halt
```
