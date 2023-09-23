# SSH client configuration using puppet

file { '/etc/ssh/ssh_config':
  ensure  => 'file',
  mode    => '0600',
  owner   => 'root',
  group   => 'root',
  content => "Host *\n\
  IdentityFile ~/.ssh/school\n\
  PasswordAuthentication no\n",
}

