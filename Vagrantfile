
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :tangerine do |web_config|
    
    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    web_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"

    web_config.vm.box = "opscode-ubuntu-1204"
    web_config.vm.network :forwarded_port, guest: 8080, host: 8888
    web_config.vm.network :forwarded_port, guest: 3306, host: 3333

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'tangerine' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "tangerine-server"
   end
    
  end
  
end
