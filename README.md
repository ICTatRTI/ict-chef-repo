
[![Build Status](https://travis-ci.org/ICTatRTI/ict-chef-repo.png?branch=ushahidi)](https://travis-ci.org/ICTatRTI/ict-chef-repo)

Quick setup
==========

1. git clone git@github.com:ICTatRTI/ict-chef-repo.git
2. cd ict-chef-repo
3 git checkout -b ushahidi origin/ushahidi
4. vagrant up
5. Go to http://localhost:8888

* Note: using the default role will configure the SI2 demo server complete with the redirect in the apache2 configuration file for the SSL version of the demo site, or https://demo.observatorio.gov.sv.  To avoid this situation just comment this line out in /etc/apache2/sites-enabled/ushahidi.conf.  When you do this the server will be available here: https://localhost:8889.



Running on Amazon Web Services
=============
 1. Install the Vagrant [https://github.com/mitchellh/vagrant-aws](AWS Plugin)
 2. Follow the Quick Start Guide from the Vagrant AWS Plugin
 3. Log into your AWS Console and verify your server has been created.

 * notes: If you are having problems connecting to the instance, check your secruity group configuration.


Using Chef Server
=============
Another way of using these scripts is with a Chef server.  To use Chef Server here are a few things you will need in order to get started. First, you'll need to configure your local client workstation.  Conveniently, this can be done with only one command.

`knife configure`


# Sample knife.rb configuration
For a reference, here is what a working knife.rb configuration file looks like:

```
current_dir = File.dirname(__FILE__)
log_level :debug
log_location STDOUT
node_name 'adampreston'
client_key '/Users/adampreston/Repository/ict-chef-repo/.chef/adampreston.pem'
validation_client_name 'chef-validator'
validation_key '/etc/chef/chef-validator.pem'
chef_server_url 'https://chef-server.idg-rti.org'
cache_type 'BasicFile'
cache_options( :path => '/Users/adampreston/Repository/ict-chef-repo/.chef/checksums' )
cookbook_path ["#{current_dir}/../cookbooks"]
cookbook_copyright "Research Triangle Institute."
cookbook_license "apachev2"
cookbook_email "apreston@rti.org"
``` 


# Bootstrap a ushahidi node
Once you have everything configured, you can bootstrap a node by doing this:

`knife bootstrap -i ~/keys/ictadmin_rsa 192.241.212.68 -N test-node -r role[base],role[ushahidi] --sudo`


