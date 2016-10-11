case $operatingsystem {
  centos, redhat: { $service_name = 'postfix' }
}

class example::postfix::client {
  package { 'postfix':
    ensure  => installed,
  }

  service { 'postfix':
    name    => $service_name,
    ensure  => running,
    enable  => true,
    subscribe => File['main.cf'],
  }

  file { 'main.cf':
    path      => '/etc/postfix/main.cf',
    ensure    => file,
    require   => Package['postfix'],
    source    => "puppet:///modules/example/main.cf"
  }
}
