[![Build Status](https://travis-ci.org/ICTatRTI/ict-chef-repo.png?branch=drupal)](https://travis-ci.org/ICTatRTI/ict-chef-repo)

Quick setup
==========

1. git clone https://github.com/ICTatRTI/ict-chef-repo.git
2. cd ict-chef-repo
3. git checkout -b drupal origin/drupal
4. vagrant up
5. Go to http://localhost:8888

* Note: When using a drupal installation running on Acquia there are a few sublte differences in how the server is built.  These differences are captured in the drupal-acquia role.  Use this instead the drupal role when you are doing it this way. Note, uncomment the sync folder line in the Vagrant file for this as well.

Common workstation tasks
=============

Configure Knife
`knife configure`

Bootstrap a plain old node
`knife bootstrap -i ~/keys/ictadmin_rsa 192.241.212.68 -N test-node -r role[base],role[drupal] --sudo`


Other useful information
=============

Sample knife.rb
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