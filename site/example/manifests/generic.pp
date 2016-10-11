class example::generic::tomcat {
  include example::generic::tomcat::user
  include example::generic::java::base
  include example::generic::tomcat::base
}

class example::generic::tomcat::user {
  group { tomcat:
    ensure     => present,
    gid        =>  5001,
  }
  user { tomcat:
    ensure     => "present",
    uid        => 5001,
    gid        => 5001,
    shell      => '/bin/bash',
    managehome => true,
    password   => '',
  }
}

class example::generic::java::base {
  $basedir = "/opt"

  # JDK
  $javatar = "jdk-8u74-linux-x64.tar.gz"
  $javaextractdir = "$basedir/jdk1.8.0_74"

  exec { 'install jdk':
    command  => "curl -l http://repo1.example.com/files/$javatar | tar -C $basedir -zx",
    creates  => "$javaextractdir",
    path     => ['/bin','/usr/bin', '/usr/local/bin'],
  }
  file { "$javaextractdir":
    recurse  => true,
    owner    => root,
    group    => root,
    require  => Exec['install jdk'],
  }
  file { "$basedir/java":
    ensure   => 'link',
    target   => "$javaextractdir",
    require  => Exec['install jdk'],
  }
}

class example::generic::tomcat::base {
  $basedir = "/opt"

  # Tomcat
  $tomcattar = "apache-tomcat-7.0.68.tar.gz"
  $tomcatextractdir = "$basedir/apache-tomcat-7.0.68"

  exec { 'install tomcat':
    command  => "curl -l http://repo1.example.com/files/$tomcattar | tar -C $basedir -zx",
    creates  => "$tomcatextractdir",
    path     => ['/bin','/usr/bin', '/usr/local/bin'],
  }
  file { "$tomcatextractdir":
    recurse  => true,
    owner    => tomcat,
    group    => tomcat,
    require  => Exec['install tomcat'],
  }
  file { "$basedir/tomcat":
    ensure   => 'link',
    target   => "$tomcatextractdir",
    require  => Exec['install tomcat'],
  }
  
  # Configuration files
  file { 'setenv.sh':
    path    => "$basedir/tomcat/bin/setenv.sh",
    content => template('example/setenv.sh'),
    require => File["$basedir/tomcat"],
  }
  
  file { '/home/tomcat/.bash_profile':
   require => User["tomcat"],
   content => template('example/bash_profile'),
  }
  
  file { 'tomcat':
    path    => '/etc/init.d/tomcat',
    require => File["$basedir/tomcat"],
    owner   => root,
    group   => root,
    mode    => 0755,
    source  => "puppet:///modules/example/tomcat-init",
  }
  
  service { "tomcat":
    ensure  => running,
    enable  => true,
    require => File["tomcat"],
  }
  
#  file { 'manager':
#    path    => "$tomcatextractdir/conf/Catalina/localhost/manager.xml",
#    require => File["tomcat"],
#    owner   => tomcat,
#    group   => tomcat,
#    mode    => 0644,
#    source  => "puppet:///modules/example/manager.xml-generic",
#    notify  => Service["tomcat"],
#  }
  
  file { 'tomcat-users':
    path    => "$tomcatextractdir/conf/tomcat-users.xml",
    require => File["tomcat"],
    owner   => tomcat,
    group   => tomcat,
    mode    => 0644,
    source  => "puppet:///modules/example/tomcat-users.xml-generic",
    notify  => Service["tomcat"],
  }
}
