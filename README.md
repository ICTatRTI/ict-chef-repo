
[![Build Status](https://travis-ci.org/ICTatRTI/ict-chef-repo.png?branch=emis-toolbox)](https://travis-ci.org/ICTatRTI/ict-chef-repo)


# Using Chef Solo
The easist way to get up and running is to use Chef Solo, which is basically running Chef client in a special mode that doesn't require access to a running Chef server.  All of these instructions are running from your local workstation.

### Running a local Virtual Machine


1. git clone git@github.com:ICTatRTI/ict-chef-repo.git
2. cd ict-chef-repo
3 git checkout -b emis-toolbox origin/emis-toolbox
4. vagrant up
5. Tthe EMIS Toolbox is available here: http://localhost:8888/emistoolbox

### Running on Amazon Web Services

 1. Install the Vagrant [AWS Plugin](https://github.com/mitchellh/vagrant-aws)
 2. Install the Vagrant [Omnibus Plugin](https://github.com/schisamo/vagrant-omnibus) * If your AMI doesn't have Chef installed already
 3. Finish configuring the Vagrantfile specifically the AWS key, secret key, private key path, security groups
 4. Run this: vagrant up --provider=aws
 5. Log into your AWS Console and verify your server has been created and provisiioned.

 * note: If you are having problems connecting to the instance, check your security group configuration. 



# Using Chef Server

Another way of using these scripts is with a Chef server.  To use Chef Server here are a few things you will need in order to get started. First, you'll need to configure your local client workstation.  Conveniently, this can be done with  one command.

`knife configure`


## Sample knife.rb configuration
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


## Bootstrap a tangerine node
Once you have everything configured, you can bootstrap a node by doing this:

`knife bootstrap -i ~/keys/ictadmin_rsa 192.241.212.68 -N test-node -r role[base],role[tangerine] --sudo`

