package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(EOF),
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
  | EOF
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}
