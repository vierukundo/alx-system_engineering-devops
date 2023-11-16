exec {'Raise the ULIMIT':
  command  => '/bin/sed -i "s/15/10000/" /etc/default/nginx',
  provider => 'shell',
}

exec {'restart nginx':
  command  => '/etc/init.d/nginx restart',
  provider => 'shell',
}
