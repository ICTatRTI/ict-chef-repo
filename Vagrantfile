
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.


config.vm.define "ushahidi" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ushahidi' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-demo"
   end
end


config.vm.define "ushahidi-si-ciudaddelgado" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ushahidi-si-ciudaddelgado' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-demo"
   end
end

config.vm.define "ushahidi-si-ayutuxtepeque" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ushahidi-si-ayutuxtepeque' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-ayutuxtepeque"
   end
end

   # Set the environment variables like this:
   #   export DIGITAL_OCEAN_CLIENT_ID=abcdefghijklmnop

   config.ssh.private_key_path = "~/.ssh/ictadmin_rsa"
   config.vm.provider :digital_ocean do |provider|
    provider.client_id = ENV['DIGITAL_OCEAN_CLIENT_ID']
    provider.api_key = ENV['DIGITAL_API_KEY']
    provider.image = "Ubuntu 12.10 x64"
    provider.region = "New York 2"
  end
  
end
