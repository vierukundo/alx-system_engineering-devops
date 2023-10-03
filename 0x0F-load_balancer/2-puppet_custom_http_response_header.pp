# Install and configure nginx
exec { 'apt-update':
  command     => 'apt-get -y update',
  path        => '/usr/bin:/bin',
  refreshonly => true,
}

package { 'nginx':
  ensure  => installed,
  require => Exec['apt-update'],
}

exec { 'edit-nginx-config':
  command => 'sudo sed -i "s|location / {|location / {\n\tadd_header X-Served-By $(hostname);|" /etc/nginx/sites-enabled/default',
  provider => shell,
  require => Package['nginx'],
}

exec { 'restart':
  command => 'sudo service nginx restart',
  provider => shell,
}
