exec {'Raise the ULIMIT':
  command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/'
}

exec {'restart nginx':
  command => '/etc/init.d/nginx restart',
  path    => '/etc/init.d/'
}
