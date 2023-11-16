# Allow login with the holberton user and open a file without any error message.

exec { 'increase-hard-file-limit':
  command => "sed -i '/^holberton hard/s/5/5000/' /etc/security/limits.conf",
  path    => '/usr/local/bin/:/bin/'
}

exec { 'increase-soft-file-limit':
  command => "sed -i '/^holberton soft/s/4/5000/' /etc/security/limits.conf",
  path    => '/usr/local/bin/:/bin/'
}
