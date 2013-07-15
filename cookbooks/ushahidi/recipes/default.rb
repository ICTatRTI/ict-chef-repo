#
# Cookbook Name:: ushahidi
# Recipe:: default
#
# Copyright 2013, Research Triangle Insitute.
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

include_recipe %w{apache2 apache2::mod_php5 apache2::mod_rewrite apache2::mod_expires}
include_recipe %w{php php::module_mysql php::module_gd php::module_curl}
include_recipe "mysql::server"

package "php5-mcrypt" do
    action :install
end 

execute "mysql-install-ushahidi-privileges" do
  command "/usr/bin/mysql -u root -p#{node['mysql']['server_root_password']} < /etc/mysql/ushahidi-grants.sql"
  action :nothing
end

template "/etc/mysql/ushahidi-grants.sql" do
  path "/etc/mysql/ushahidi-grants.sql"
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :user     => node['ushahidi']['db']['user'],
    :password => node['ushahidi']['db']['password'],
    :database => node['ushahidi']['db']['database']
  )
  notifies :run, resources(:execute => "mysql-install-ushahidi-privileges"), :immediately
end

execute "create #{node['ushahidi']['db']['database']} database" do
  command "/usr/bin/mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['ushahidi']['db']['database']}"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names --execute=\"show databases like '#{node['ushahidi']['db']['database']}'\" | grep #{node['ushahidi']['db']['database']}"
end

execute "git clone https://github.com/ushahidi/Ushahidi_Web.git" do
  cwd "#{node.ushahidi.dir}"
  action :run
end

directory "#{node.ushahidi.dir}/Ushahidi_Web/application/logs" do
  group node['apache']['user']
  mode "775"
end

directory "#{node.ushahidi.dir}/Ushahidi_Web/application/cache" do
  group node['apache']['user']
  mode "775"
end

directory "#{node.ushahidi.dir}/Ushahidi_Web/application/config" do
  group node['apache']['user']
  mode "775"
end

directory "#{node.ushahidi.dir}/Ushahidi_Web/media/uploads" do
  group node['apache']['user']
  mode "775"
end

file "#{node.ushahidi.dir}/Ushahidi_Web/.htaccess" do
  group node['apache']['user']
  mode "775"
end

web_app "ushahidi" do
  template "ushahidi.conf.erb"
  docroot "#{node.ushahidi.dir}/Ushahidi_Web"
  server_name server_fqdn
  server_aliases node['fqdn']
end

execute "disable-default-site" do
   command "sudo a2dissite default"
   notifies :reload, resources(:service => "apache2"), :delayed
end


