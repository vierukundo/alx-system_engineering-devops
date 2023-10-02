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

# Create a custom 404 error page
error_page { '/var/www/html/404.html':
  ensure  => file,
  content => "Ceci n'est pas une page\n",
  require => Package['nginx'],
}

# Add a custom error page configuration to Nginx
path_to_page_error { 'custom-error-page':
  path    => '/etc/nginx/sites-enabled/default',
  line    => "  location /xyzfoo {\n    alias /var/www/html/404.html;\n  }",
  match   => 'server_name _;',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Add X-Served-By header to Nginx configuration
server_hostname=$(hostname)

header_line { 'add-x-served-by-header':
  path    => '/etc/nginx/sites-enabled/default',
  line    => "    add_header X-Served-By $server_hostname;",
  match   => 'location / {',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'], # Ensure Nginx package is installed before starting the service
}
