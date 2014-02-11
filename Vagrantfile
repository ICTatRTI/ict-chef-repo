
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

config.vm.define "ushahidi-si-demo" do |web_config|
    
    # web_config.vm.box = "digital_ocean"
    # web_config.omnibus.chef_version = :latest
    
    web_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"
    web_config.vm.box = "opscode-ubuntu-1204"
    
    web_config.vm.network :forwarded_port, guest: 80, host: 8080
    web_config.vm.network :forwarded_port, guest: 443, host: 8443
    web_config.vm.network :forwarded_port, guest: 3306, host: 3333

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ushahidi' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-demo"
   end
end

   

config.vm.define "ushahidi-si-antigou" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'antigou' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-antigou"
   end
end

config.vm.define "ushahidi-si-sanmartin" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'sanmartin' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-sanmartin"
   end
end

config.vm.define "ushahidi-si-sansalvador" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'sansalvador' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-sansalvador"
   end
end

config.vm.define "ushahidi-si-santatecla" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'santatecla' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-santatecla"
   end
end

config.vm.define "ushahidi-si-apopa" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ciudaddelgado' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-apopa"
   end
end

config.vm.define "ushahidi-si-ciudaddelgado" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ciudaddelgado' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-ciudaddelgado"
   end
end

config.vm.define "ushahidi-si-ayutuxtepeque" do |web_config|
    
    web_config.vm.box = "digital_ocean"
    web_config.omnibus.chef_version = :latest

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'ayutuxtepeque' 
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "si-ayutuxtepeque"
   end
end

   #  
   # Uncomment all of this when using the digital ocean provider
   # export DIGITAL_OCEAN_CLIENT_ID=abcdefghijklmnop

   #config.ssh.private_key_path = "~/.ssh/ictadmin_rsa"
   #config.vm.provider :digital_ocean do |provider|
    #provider.client_id = ENV['DIGITAL_OCEAN_CLIENT_ID']
    #provider.api_key = ENV['DIGITAL_API_KEY']
    #provider.image = "Ubuntu 12.10 x64"
    #provider.region = "New York 2"
  #end
  
end
