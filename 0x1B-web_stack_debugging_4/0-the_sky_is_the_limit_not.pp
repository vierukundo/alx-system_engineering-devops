exec {'Raise_the_ULIMIT':
  command  => 'sed -i "s/15/10000/" /etc/default/nginx',
  provider => 'shell',
}

exec {'restart nginx':
  command  => 'service nginx restart',
  provider => 'shell',
}
