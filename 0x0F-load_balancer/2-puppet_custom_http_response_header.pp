# 2-puppet_custom_http_response_header.pp

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(EOF),
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        add_header X-Served-By \$hostname;
        try_files \$uri \$uri/ =404;
    }

    location = /redirect_me {
        add_header X-Served-By \$hostname;
        return 301 https://www.blog.ehoneahobed.com;
    }
}
    | EOF
  notify  => Service['nginx'],
}

