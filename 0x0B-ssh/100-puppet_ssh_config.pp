# Ensure .ssh directory exists
file { '/home/ubuntu/.ssh':
  ensure  => 'directory',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0700',
}

# Ensure the config file exists
file { '/home/ubuntu/.ssh/config':
  ensure  => 'file',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
  require => File['/home/ubuntu/.ssh'],
}

# Add IdentityFile declaration
file_line { 'Declare identity file':
  ensure  => present,
  path    => '/home/ubuntu/.ssh/config',
  line    => '    IdentityFile /home/ubuntu/.ssh/school',
  match   => '^\s*IdentityFile',
  require => File['/home/ubuntu/.ssh/config'],
}

# Turn off password authentication
file_line { 'Turn off passwd auth':
  ensure  => present,
  path    => '/home/ubuntu/.ssh/config',
  line    => '    PasswordAuthentication no',
  match   => '^\s*PasswordAuthentication',
  require => File['/home/ubuntu/.ssh/config'],
}
