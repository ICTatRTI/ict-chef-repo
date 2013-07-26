name             'ushahidi'
maintainer       'Research Triangle Insitute.'
maintainer_email 'apreston@rti.org'
license          'Apache 2.0'
description      'Installs/Configures ushahidi'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

%w{ php apache2 mysql }.each do |cb|
  depends cb
end
