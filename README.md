# DevOps Exercise

> Use `chef-solo` to develop an automated deployment and configuration system

Chef-solo is used in combination with Vagrant to complete the following tasks:
- Deploy and daemonize a static web server available from `npm`.
- Configure the webserver to serve only a single file by default, the chef-solo installation log that is a result of the installation.
- Install and configure Nginx with access through "https" and "http basic authentication".
- Issue an http post to a given endpoint, easily configured when executing the chef script (e.g. https://arterys.com/install-complete). It should not post if the endpoint is not configured when the script is run.

# Prerequisites
- [Vagrant 1.9.8 (any 1.X should work too, but NOT 2.0 as Berkshelf plugin is not compatible at the time of writing)](https://releases.hashicorp.com/vagrant/1.9.8/)
- [Chef Development Kit (ChefDK)](https://downloads.chef.io/chefdk)

# Installation

Clone repository:
```bash
$ git clone https://github.com/lvaylet/devops-exercise
```

Install Vagrant plugins to simplify provisioning with Chef Solo. Berkshelf is a tool for managing cookbook dependencies (i.e. Chef's dependency management system). Omnibus can install any version of Chef or ensure we're using the latest one.
```bash
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
```

# Usage

Fire up and provision VM with IP `192.168.50.4` on private network:
```bash
$ cd devops-exercise
$ vagrant up
```

Display Chef log. Use basic authentication over HTTPS and SSL with unsecured self-signed certificate (for test purposes). When using a browser, you might have to add an exception on every new instance created by `vagrant up` because of the automatically generated self-signed certificate.
```bash
$ curl -X GET --user sammy:pass --insecure https://192.168.50.4
```

You should get something like:
```
# Logfile created on 2017-09-14 13:12:07 +0000 by logger.rb/44203
[2017-09-14T13:12:07+00:00] INFO: Forking chef instance to converge...
[2017-09-14T13:12:07+00:00] INFO: *** Chef 12.7.2 ***
[2017-09-14T13:12:07+00:00] INFO: Chef-client pid: 1865
[2017-09-14T13:12:08+00:00] INFO: Setting the run_list to ["recipe[apt_update]", "recipe[nodejs]", "recipe[node_static_server]", "recipe[nginx_ssl_auth]"] from CLI options
...
[2017-09-14T13:13:14+00:00] INFO: service[nginx] restarted
[2017-09-14T13:13:14+00:00] INFO: Chef Run complete in 65.634720772 seconds
[2017-09-14T13:13:14+00:00] INFO: Skipping removal of unused files from the cache
[2017-09-14T13:13:14+00:00] INFO: Running report handlers
[2017-09-14T13:13:14+00:00] INFO: Report handlers complete
```

When you are done, gracefully shut down the VM with:
```bash
$ vagrant halt
```

In case you need to provision the VM again after making some changes, you can use:
```bash
$ vagrant reload --provision
```

Finally, to delete the VM and restart from scratch, you can use:
```bash
$ vagrant destroy
```

# Extra

1. Explain various options available to email the chef-solo log file when the installation is complete.

I would probably use an SMTP server available in Ubuntu, like postfix. It can easily be configured to send emails through an existing third-party email provider (e.g. ops@arterys.com with Google services under the hood). Another option is to [configure postfix as a local send-only SMTP server](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-14-04) to remove any dependency on an external provider. Finally, [this tutorial](https://www.frankmitchell.org/2013/03/chef-handlers/) explains how to send email notifications from Chef when the run fails. It could be adjusted to send emails when the installation completes successfully.

2. Explain various options available to monitor the system logs on this server remotely.

Monitoring the logs manually could be as simple as logging in through SSH and `tail -f` the relevant log file(s). [Nagios](https://www.nagios.org/) or an [Elasticsearch + Logstash + Kibana stack](https://www.digitalocean.com/community/tutorial_series/centralized-logging-with-elk-stack-elasticsearch-logstash-and-kibana-on-ubuntu-14-04) are good options if the process needs to be automated, with alerts and notifications when something goes wrong.
