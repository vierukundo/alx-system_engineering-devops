# Installing flask from pip3 using puppet

package { 'python3-pip':
  ensure => 'installed',
}

exec { 'install_flask':
  command => '/usr/bin/pip3 install flask==2.1.0',
  path    => '/usr/local/bin:/usr/bin:/bin', # Add the path to pip3 if needed
  unless  => '/usr/bin/pip3 show flask | grep Version | grep -q 2.1.0',
  require => Package['python3-pip'], # Ensure pip3 is installed first
}
