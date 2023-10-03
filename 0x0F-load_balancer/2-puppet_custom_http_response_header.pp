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

# Get the hostname of the server
$server_hostname = $facts['fqdn']

$org_string = "location / {"
$new_string = "location / {\n\t\tadd_header X-Served-By $server_hostname;\n"

# Use 'sed' to modify Nginx configuration
exec { 'modify-nginx-config':
  command => "sudo sed -i 's|${org_string}|${new_string}|' /etc/nginx/sites-enabled/default",
  path    => '/usr/bin:/bin',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Restart Nginx
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Exec['modify-nginx-config'],
}
