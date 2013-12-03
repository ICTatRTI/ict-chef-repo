
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :ushahidi do |web_config|
    
    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    #web_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"

    web_config.vm.box = "opscode-ubuntu-1204"
    #web_config.vm.box = "digital_ocean"
    #web_config.omnibus.chef_version = :latest


    web_config.vm.network :forwarded_port, guest: 80, host: 8888
    web_config.vm.network :forwarded_port, guest: 443, host: 8889
    web_config.vm.network :forwarded_port, guest: 3306, host: 3333

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ushahidi' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-demo"
   end
  end

  # To use the Digital Ocean provider (0.4.1) do the following 2 things:
  # 1.) Replace the vm.box above with this: config.vm.box = "digital_ocean"
  # 2.) Uncomment the omnibus.chef_version line above 
  # 3.) Uncomment the following lines and obviously put in your API and Client Key
    
   #config.ssh.private_key_path = "~/.ssh/ictadmin_rsa"
   #config.vm.provider :digital_ocean do |provider|
    #provider.client_id = "YOUR CLIENT KEY"
    #provider.api_key = "API KEY"
    #provider.image = "Ubuntu 12.10 x64"
    #provider.region = "New York 2"
  #end
  
end
