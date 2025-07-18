# 7-puppet_install_nginx_web_server.pp

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure => running,
  enable => true,
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx_web/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}
