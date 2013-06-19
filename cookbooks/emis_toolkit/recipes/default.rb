#
# Cookbook Name:: emus_toolkit
# Recipe:: default
#
# Copyright 2013, RTI
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


cookbook_file "#{node.tomcat.webapp_dir}/emistoolbox.war" do
  source "emistoolbox.war"
  mode 0755
end

directory "/opt/emistoolbox" do
  owner "root"
  group "#{node.tomcat.user}"
  mode 00774
  action :create
end

cookbook_file "/opt/emistoolbox/users.xml" do
  source "users.xml"
  mode 0755
end

directory "/opt/emistoolbox/default" do
  owner "root"
  group "#{node.tomcat.user}"
  mode 00774
  action :create
end

cookbook_file "/opt/emistoolbox/default/data.bin" do
  source "data.bin"
  mode 0755
end

cookbook_file "/opt/emistoolbox/default/model.xml" do
  source "model.xml"
  mode 0755
end

cookbook_file "/opt/emistoolbox/default/report.xml" do
  source "report.xml"
  mode 0755
end

cookbook_file "/opt/emistoolbox/default/mapping.xml" do
  source "mapping.xml"
  mode 0755
end