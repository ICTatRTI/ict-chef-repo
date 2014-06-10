#
# Cookbook Name:: tangerine_utility
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "help2man" do
    action :install
end 

package "libssl-dev" do
    action :install
end 

package "apache2-prefork-dev" do
    action :install
end 

package "libapr1-dev" do
    action :install
end 

package "libaprutil1-dev" do
    action :install
end 

package "libcurl4-openssl-dev" do
    action :install
end 

package "rubygems" do
    action :install
end 

gem_package "sinatra" do
  action :install
end

gem_package "sinatra-cross_origin" do
  action :install
end

gem_package "mime-types" do
  action :install
  version "1.16"
end

gem_package "rest-client" do
  action :install
end



execute "git clone https://github.com/Tangerine-Community/tree.git" do
  cwd "#{node.tangerine.wwwdir}"
  action :run
end

directory "#{node.tangerine.wwwdir}/tree/tmp" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

directory "#{node.tangerine.wwwdir}/tree/public" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

file "#{node.tangerine.wwwdir}/tree/tree.log" do
  owner "root"
  group "root"
  mode 00777
  action :touch
end

execute "git clone git://github.com/Tangerine-Community/robbert.git" do
  cwd "#{node.tangerine.wwwdir}"
  action :run
end

ruby_block "Rename configuration file" do
  block do
    ::File.rename("#{node.tangerine.wwwdir}/robbert/Config.php.sample","#{node.tangerine.wwwdir}/robbert/Config.php")
  end
end
 
web_app "tangerine" do
  template "tangerine.conf.erb"
  docroot "#{node.tangerine.wwwdir}"
  server_name server_fqdn
  server_aliases node['fqdn']
end

service "apache2" do
  action :restart
end
 