# Ensure the SSH config file exists
file { '/home/ubuntu/.ssh/config':
  ensure  => 'file',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
}

# Add IdentityFile declaration
file_line { 'Declare identity file':
  ensure => present,
  path   => '/home/ubuntu/.ssh/config',
  line   => '    IdentityFile /home/ubuntu/.ssh/school',
  match  => '^\s*IdentityFile',
}

# Turn off password authentication
file_line { 'Turn off passwd auth':
  ensure => present,
  path   => '/home/ubuntu/.ssh/config',
  line   => '    PasswordAuthentication no',
  match  => '^\s*PasswordAuthentication',
}
# Notice: Compiled catalog for ubuntu-xenial in environment production in 0.11 seconds
# Notice: /Stage[main]/Main/File_line[Turn off passwd auth]/ensure: created
# Notice: /Stage[main]/Main/File_line[Declare identity file]/ensure: created
# Notice: Finished catalog run in 0.03 seconds
