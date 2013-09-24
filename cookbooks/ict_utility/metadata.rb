name             'ict_utility'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'Apache 2.0'
description      'Installs/Configures ict_utility'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

%w{ php apache2 mysql openssl }.each do |cb|
  depends cb
end

%w{ debian ubuntu }.each do |os|
  supports os
end