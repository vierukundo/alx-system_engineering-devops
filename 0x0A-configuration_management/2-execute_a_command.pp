# create a manifest that kills a process named killmenow using puppet

exec { 'kill_killmenow':
  command => 'pkill -f "killmenow"',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => 'pkill -f "killmenow"',
}
