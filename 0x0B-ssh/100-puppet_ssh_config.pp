# SSH client configuration using puppet

file { '/etc/ssh/ssh_config':
  ensure  => 'file',
  mode    => '0644',
  owner   => 'root',
  content => "Host *\n\
  IdentityFile ~/.ssh/school\n\
  PasswordAuthentication no\n",
}

