#
# Author:: Marius Ducea (marius@promethost.com)
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright 2010, Promet Solutions
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
include_recipe %w{php php::module_mysql php::module_gd}
include_recipe "mysql::server"

execute "mysql-install-drupal-privileges" do
  command "/usr/bin/mysql -u root -p#{node['mysql']['server_root_password']} < /etc/mysql/drupal-grants.sql"
  action :nothing
end

template "/etc/mysql/drupal-grants.sql" do
  path "/etc/mysql/drupal-grants.sql"
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(
    :user     => node['drupal']['db']['user'],
    :password => node['drupal']['db']['password'],
    :database => node['drupal']['db']['database']
  )
  notifies :run, resources(:execute => "mysql-install-drupal-privileges"), :immediately
end

execute "create #{node['drupal']['db']['database']} database" do
  command "/usr/bin/mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['drupal']['db']['database']}"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names --execute=\"show databases like '#{node['drupal']['db']['database']}'\" | grep #{node['drupal']['db']['database']}"
end


if node.has_key?("ec2")
  server_fqdn = node['ec2']['public_hostname']
else
  server_fqdn = node['fqdn']
end


web_app "drupal" do
  template "drupal.conf.erb"
  docroot node['drupal']['dir']
  server_name server_fqdn
  server_aliases node['fqdn']
end

include_recipe "drupal::cron"



