file { '/home/brendajb/.ssh':
  ensure => 'directory',
  mode   => '0700',
  owner  => 'brendajb',
  group  => 'brendajb',
}

file { '/home/brendajb/.ssh/config':
  ensure  => 'file',
  content => "Host github.com\n  IdentityFile ~/.ssh/id_rsa\n  PasswordAuthentication no\n",
  owner   => 'brendajb',
  group   => 'brendajb',
  mode    => '0600',
  require => File['/home/brendajb/.ssh'],
}
