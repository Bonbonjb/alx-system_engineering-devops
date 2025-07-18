# 2-puppet_custom_http_response_header.pp

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}

exec { 'set custom header':
  command => 'sed -i "/location \/ {/a\\        add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
  unless  => 'grep -q "add_header X-Served-By" /etc/nginx/sites-available/default',
  notify  => Service['nginx'],
  require => Package['nginx'],
}
