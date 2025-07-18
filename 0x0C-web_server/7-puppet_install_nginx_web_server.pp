class nginx_web {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    require    => Package['nginx'],
  }

  file { '/var/www/html/index.nginx-debian.html':
    ensure  => file,
    content => "Hello World!\n",
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => template('nginx_web/default.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
}

include nginx_web
