require 'chefspec'

  describe 'my_new_cookbook::default' do
    let (:chef_run) { ChefSpec::ChefRunner.new.converge 'ict_utility::default' }

    it 'installs the unzip package' do
     chef_run.should install_package 'unzip'
   end

   it 'installs the vim package' do
     chef_run.should install_package 'vim'
   end
   
end