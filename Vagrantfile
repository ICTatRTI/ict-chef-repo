Vagrant.configure('2') do |config|

  config.vm.define "emistoolbox" do |web_config|
    
    web_config.vm.provision :chef_solo do |chef|
     chef.node_name = 'emistoolbox' 
     chef.cookbooks_path = './cookbooks'
     chef.roles_path = './roles'
     chef.add_role 'base'
     chef.add_role 'emis'
    end
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = ENV['SSL_KEY_PATH']
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

    provider.token = ENV['DIGITAL_OCEAN_TOKEN']
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'nyc2'
    provider.size = '2gb'
  end
end