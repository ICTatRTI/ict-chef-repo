

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :tangerine do |web_config|
    
    # used by the aws provisioner
    web_config.omnibus.chef_version = :latest
    
    web_config.vm.box = "chef/ubuntu-12.04"
    
    web_config.vm.network :forwarded_port, guest: 8080, host: 8888
    web_config.vm.network :forwarded_port, guest: 3306, host: 3307
    web_config.vm.network :forwarded_port, guest: 5984, host: 5984

    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'tangerine'
     chef.cookbooks_path = "./cookbooks"
     chef.roles_path = "./roles"
     chef.add_role "base"
     chef.add_role "tangerine-server"
   end

    # uncomment all of this stuff to use the AWS plugin
     # web_config.vm.provider :aws do |aws, override|
       # aws.access_key_id = "your.key"
       # aws.secret_access_key = "your.secret.key"
       # aws.keypair_name = "Your Key Pair Name"
       # aws.ami = "ami-7747d01e"
       # aws.security_groups = ["Basic Access"]
       # override.ssh.username = "ubuntu"
       # override.ssh.private_key_path = "/path/to/private/key"
     # end
    
  end
  
end
