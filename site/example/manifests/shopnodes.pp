class example::shopnodes::logrotate { 
  if $environment == production {
    $location = "shopprod"
  } elsif $environment == stage {
    $location = "shopstage"
  } elsif $environment == test {
    $location = "shoptest"
  }
  file { "/etc/logrotate.d/shop-tomcat":
    owner    => root,
    group    => root,
    mode     => 0644,
    content  => template('example/shop-tomcat-logrotate'),
  }
  if $environment == production {
    service { "tomcat":
      ensure   => running,
      enable   => true,
    }
  }
}
