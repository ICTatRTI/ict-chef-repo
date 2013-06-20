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

gem_package "rest-client" do
  action :install
end



 
 