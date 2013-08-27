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

include_recipe %w{apache2 apache2::mod_php5 apache2::mod_rewrite apache2::mod_expires apache2::mod_ssl}
include_recipe %w{php php::module_mysql php::module_gd php::module_curl}
include_recipe "mysql::server"

package "php5-mcrypt" do
    action :install
end 

package "php5-imap" do
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
    :database => node['ushahidi']['db']['schema']
  )
  notifies :run, resources(:execute => "mysql-install-ushahidi-privileges"), :immediately
end

execute "create #{node['ushahidi']['db']['schema']} database" do
  command "/usr/bin/mysqladmin -u root -p#{node['mysql']['server_root_password']} create #{node['ushahidi']['db']['schema']}"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names --execute=\"show databases like '#{node['ushahidi']['db']['schema']}'\" | grep #{node['ushahidi']['db']['schema']}"
end

execute "git clone https://github.com/ICTatRTI/Ushahidi_Web.git" do
  cwd node['ushahidi']['dir']
  action :run
  not_if { ::File.exists?("#{node.ushahidi.dir}/Ushahidi_Web")}
end

execute "git checkout -f #{node['ushahidi']['application']['version']}" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "rm -rf i18n" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web/application"
  not_if { ::File.exists?("#{node.ushahidi.dir}/Ushahidi_Web/application/i18n/README")}
  action :run
end

execute "git clone git://github.com/ushahidi/Ushahidi-Localizations.git i18n" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web/application"
  not_if { ::File.exists?("#{node.ushahidi.dir}/Ushahidi_Web/application/i18n/README")}
  action :run
end


execute "git clone https://github.com/ICTatRTI/linkreports.git linkreports" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web/plugins"
  not_if { ::File.exists?("#{node.ushahidi.dir}/Ushahidi_Web/plugins/linkreports")}
  action :run
end


execute "git clone https://github.com/ICTatRTI/SI2WebTheme.git SI2" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web/themes"
  not_if { ::File.exists?("#{node.ushahidi.dir}/Ushahidi_Web/themes/SI2")}
  action :run
end

execute "create geodata database" do
  command "/usr/bin/mysqladmin -u root -p#{node['mysql']['server_root_password']} create geodata"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names --execute=\"show databases like 'geodata'\" | grep geodata"
end

cookbook_file "/etc/mysql/giswithin.sql" do
  source "giswithin.sql"
  owner "root"
  mode "644"
end

execute "initialize add GISWithin Function" do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/giswithin.sql "
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} #{node['ushahidi']['db']['schema']} --execute=\"SHOW FUNCTION STATUS\" | grep GISWithin"
 end


cookbook_file "/etc/mysql/geodata.sql" do
  source "geodata.sql"
  owner "root"
  mode "644"
end

execute "initialize geodata database" do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/geodata.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} geodata --execute=\"show tables\" | grep ."
 end

## Configure
ruby_block "Rename configuration file" do
  block do
    ::File.rename("#{node.ushahidi.dir}/Ushahidi_Web/application/config/config.template.php","#{node.ushahidi.dir}/Ushahidi_Web/application/config/config.php")
    ::File.rename("#{node.ushahidi.dir}/Ushahidi_Web/application/config/auth.template.php","#{node.ushahidi.dir}/Ushahidi_Web/application/config/auth.php")
    ::File.rename("#{node.ushahidi.dir}/Ushahidi_Web/application/config/encryption.template.php","#{node.ushahidi.dir}/Ushahidi_Web/application/config/encryption.php")
    ::File.rename("#{node.ushahidi.dir}/Ushahidi_Web/application/config/database.template.php","#{node.ushahidi.dir}/Ushahidi_Web/application/config/database.php")
  end
end


execute "sed  --in-place \"s/.*'marker_radius'.*/\\$config['marker_radius'] = \\\"2\\\";/g\" application/config/map.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'marker_opacity'.*/\\$config['marker_opacity'] = \\\"5\\\";/g\" application/config/config.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'site_protocol'.*/\\$config['site_protocol'] = \\\"https\\\";/g\" application/config/config.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'enable_auto_upgrader'.*/\\$config['enable_auto_upgrader'] = \\\"FALSE\\\";/g\" application/config/config.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'installer_check'.*/\\$config['installer_check'] = \\\"FALSE\\\";/g\" application/config/config.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'default'..'key'.*/\\$config['default']['key'] = \\\"01yo7DT4S5B0KqfOVk0DKR10637brfmGRYIz5Pw9a65W8tJlx0IG16AFmmVWn2Tx97P6fs\\\";/g\" application/config/encryption.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed  --in-place \"s/.*'domain'.*/\\$config['domain'] = \\\"#{node.ushahidi.application.url}\\\";/g\" application/config/cookie.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :nothing
end

execute "sed  --in-place \"s/.*'domain'.*/\\$config['secure'] = \\\"TRUE\\\";/g\" application/config/cookie.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :nothing
end


execute "sed --in-place \"s/password/#{node['ushahidi']['db']['password']}/g\" application/config/database.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed --in-place \"s/username/#{node['ushahidi']['db']['user']}/g\" application/config/database.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "sed --in-place \"s/db/#{node['ushahidi']['db']['schema']}/g\" application/config/database.php" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "initialize database" do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < #{node['ushahidi']['dir']}/Ushahidi_Web/sql/ushahidi.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} #{node['ushahidi']['db']['schema']} --execute=\"show tables\" | grep ."
 end

execute "rm -rf installer" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end


#Customize Data base
cookbook_file "/etc/mysql/db_customization.sql" do
  source "db_customization.sql"
  owner "root"
  mode "644"
end

execute "Load in database customizations #{node['ushahidi']['db']['schema']} " do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_customization.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names #{node['ushahidi']['db']['schema']} --execute=\"select * from settings where id = 4\" | grep observatorio.amss@gmail.com"
  action :run
end

cookbook_file "/etc/mysql/db_enable_geometry.sql" do
  source "db_enable_geometry.sql"
  owner "root"
  mode "644"
end

execute "Load in database geometery #{node['ushahidi']['db']['schema']} " do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_enable_geometry.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']} --silent --skip-column-names #{node['ushahidi']['db']['schema']} --execute=\"describe location\" | grep location_point"
end

cookbook_file "/etc/mysql/db_views.sql" do
  source "db_views.sql"
  owner "root"
  mode "644"
end

execute "Load in database views #{node['ushahidi']['db']['schema']} " do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_views.sql"
end

cookbook_file "/etc/mysql/db_forms.sql" do
  source "db_forms.sql"
  owner "root"
  mode "644"
end

execute "Load in database forms #{node['ushahidi']['db']['schema']} " do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_forms.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']}  #{node['ushahidi']['db']['schema']} --execute=\"select form_title from form where id = 102\" | grep VEHICULOS"
end

cookbook_file "/etc/mysql/db_views_custom_forms.sql" do
  source "db_views_custom_forms.sql"
  owner "root"
  mode "644"
end

execute "Load in database custom forms #{node['ushahidi']['db']['schema']} " do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_views_custom_forms.sql"
end


execute "Dump incident form form_field form_field_option form_response to temp" do
  command "/usr/bin/mysqldump -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} incident form form_field form_field_option form_response > /tmp/ushahidi-data.sql"
end

execute "sed --in-place \"s/ENGINE=MyISAM/ENGINE=InnoDB/g\" /tmp/ushahidi-data.sql" do
  cwd "#{node.ushahidi.dir}/Ushahidi_Web"
  action :run
end

execute "Load in updates to Engine" do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /tmp/ushahidi-data.sql"
end

execute "rm -f ushahidi-data.sql" do
  cwd "/tmp"
  action :run
end

cookbook_file "/etc/mysql/db_fks.sql" do
  source "db_fks.sql"
  owner "root"
  mode "644"
end

execute "Update the foreign keys" do
  command "/usr/bin/mysql -u #{node['ushahidi']['db']['user']}  -p#{node['ushahidi']['db']['password']}  #{node.ushahidi.db.schema} < /etc/mysql/db_fks.sql"
  not_if "mysql -u root -p#{node['mysql']['server_root_password']}  #{node['ushahidi']['db']['schema']} --execute=\"SHOW CREATE TABLE form_field\" | grep FK_form_id"
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
  template "ushahidi.erb"
  docroot "#{node.ushahidi.dir}/Ushahidi_Web"
end

cookbook_file "/etc/mysql/db_customization.sql" do
  source "db_customization.sql"
  owner "root"
  mode "644"
end

cookbook_file "/etc/apache2/ssl/apache.crt" do
  source "apache.crt"
  owner "root"
  mode "644"
  action :create_if_missing
end

cookbook_file "/etc/apache2/ssl/apache.key" do
  source "apache.key"
  owner "root"
  mode "644"
  action :create_if_missing
end

cookbook_file "/etc/apache2/ssl/intermediate.crt" do
  source "intermediate.crt"
  owner "root"
  mode "644"
  action :create_if_missing
end

web_app "ushahidi-ssl" do
  template "ushahidi-ssl.erb"
  docroot "#{node.ushahidi.dir}/Ushahidi_Web"
end

execute "disable-default-site" do
   command "sudo a2dissite default"
   notifies :reload, resources(:service => "apache2"), :delayed
end

execute "echo \"ServerName localhost\" | sudo tee /etc/apache2/conf.d/fqdn" do
  action :run
end
