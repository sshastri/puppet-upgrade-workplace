class example::app::responsys {
  $basedir = "/opt"
  file { "/var/responsys":
    ensure     => directory,
    owner      => tomcat,
    group      => tomcat,
    mode       => 0775,
  }
  file { "/var/responsys/uploads":
    ensure     => directory,
    owner      => tomcat,
    group      => tomcat,
    mode       => 0775,
    require    => File["/var/responsys"],
  }
  file { "/var/responsys/downloads":
    ensure     => directory,
    owner      => tomcat,
    group      => tomcat,
    mode       => 0775,
    require    => File["/var/responsys"],
  }
  if $hostname =~ /stage/ {
    file { 'responsys-context.xml':
      path    => "$basedir/tomcat/conf/Catalina/localhost/emailrs.xml",
      content => template('example/context.xml-non-prod-responsys'),
      require => File["$basedir/tomcat"],
      notify  => Service["tomcat"],
    }
  } elsif $hostname =~ /webemailprod2/ {
    file { 'responsys-context.xml':
      path    => "$basedir/tomcat/conf/Catalina/localhost/emailrs.xml",
      content => template('example/context.xml-prod-responsys'),
      require => File["$basedir/tomcat"],
      #notify  => Service["tomcat"],
    }
  }
}
