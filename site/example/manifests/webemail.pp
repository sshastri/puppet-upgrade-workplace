# Webemail config
class example::webemail::config {
  $basedir = "/opt"

  # JDK
  $javatar = "jdk-8u31-linux-x64.tar.gz"
  $javaextractdir = "$basedir/jdk1.8.0_31"

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

  # Tomcat
  $tomcattar = "apache-tomcat-7.0.57.tar.gz"
  $tomcatextractdir = "$basedir/apache-tomcat-7.0.57"

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
  if $hostname =~ /webemailstage/ {
    file { 'context.xml':
      path    => "$basedir/tomcat/conf/Catalina/localhost/emailbatch.xml",
      content => template('example/context.xml-stage-new'),
      require => File["$basedir/tomcat"],
      notify  => Service["tomcat"],
    }
  } elsif $hostname =~ /webemailprod2/ {
    file { 'context.xml':
      path    => "$basedir/tomcat/conf/Catalina/localhost/emailbatch.xml",
      content => template('example/context.xml-emailbatch-prod'),
      require => File["$basedir/tomcat"],
      #notify  => Service["tomcat"],
    }
    
  } elsif $hostname =~ /webemaildev2/ or $hostname =~ /webemailtest4/ or $hostname =~ /webemailstage4/ {
  }
      
   # else {
   # file { 'context.xml':
   #   path    => "$basedir/tomcat/conf/Catalina/localhost/emailbatch.xml",
   #   content => template('example/context.xml-stage-new'),
   #   require => File["$basedir/tomcat"],
   #   notify  => Service["tomcat"],
   # }
  #}
  
  file { 'setenv.sh':
    path    => "$basedir/tomcat/bin/setenv.sh",
    content => template('example/setenv.sh'),
    require => File["$basedir/tomcat"],
  }
  
  file { '/home/tomcat/.bash_profile':
   require => User["tomcat"],
   content => template('example/bash_profile'),
  }

  file { '/opt/tomcat/conf/jmxremote.access':
    require => File["$basedir/tomcat"],
    owner   => tomcat,
    group   => tomcat,
    mode    => 0700,
    source  => "puppet:///modules/example/jmxremote.access",
  }
  
  file { '/opt/tomcat/conf/jmxremote.password':
    require => File["$basedir/tomcat"],
    owner   => tomcat,
    group   => tomcat,
    mode    => 0700,
    source  => "puppet:///modules/example/jmxremote.password",
  }
  
  file { 'tomcat':
    path    => '/etc/init.d/tomcat',
    require => File["$basedir/tomcat"],
    owner   => root,
    group   => root,
    mode    => 0755,
    source  => "puppet:///modules/example/tomcat-init",
  }
  if $hostname =~ /webemailprod1/ {
    service { "tomcat":
      ensure => stopped,
      enable => false,
    }
  } else {
    service { "tomcat":
      ensure  => running,
      enable  => true,
      require => File["tomcat"],
    }
  }
}

