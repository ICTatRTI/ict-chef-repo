
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode-ubuntu-1204"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"


  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #

  config.vm.network :forwarded_port, guest: 8080, host: 8888
  config.vm.network :forwarded_port, guest: 3306, host: 3333

  config.vm.provision :chef_solo do |chef|

     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     #chef.data_bags_path = "../my-recipes/data_bags"
     chef.add_role "base"
     chef.add_role "tangerine-server"

     


   end

  
end
