# 0-the_sky_is_the_limit_not.pp

exec {'raise_the_ULIMIT':
  command => 'sed -i "s|ULIMIT=\"-n 15\"|ULIMIT=\"-n 10000\"|" /etc/default/nginx',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
}

exec {'restart_nginx':
  command => 'service nginx restart',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
}
