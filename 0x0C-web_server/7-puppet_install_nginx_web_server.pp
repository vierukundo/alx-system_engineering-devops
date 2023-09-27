# Install and configure nginx
exec { 'apt-update':
  command     => 'apt-get -y update',
  path        => '/usr/bin:/bin',
  refreshonly => true,
}

package { 'nginx':
  ensure => installed,
  require => Exec['apt-update'],
}

file { '/var/www/html/index.nginx-debian.html':
  content => 'Hello World!',
}

file_line { 'add_redirect':
  path   => '/etc/nginx/sites-enabled/default',
  after  => 'server_name _;',
  line   => '    location /redirect_me {return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;}',
  notify => Service['nginx'], # Notify Nginx service to restart when the config changes
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'], # Ensure Nginx package is installed before starting the service
}

