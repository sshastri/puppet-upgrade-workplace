class example::oracle::db {
  include example::dba::users
  include example::oracle::common
  include example::oracle::u01
  include example::iscsi::base
  include example::oracle::nfs::stage
  include example::oracle::nfs::exp
  if $hostname =~ /prod/ {
    include example::oracle::nfs::arch
  }
}
class example::oracle::app {
  include example::dba::users
  include example::oracle::common
  include example::oracle::nfs::stage
}

class example::oracle::common {
  if $operatingsystemrelease =~ /5/ {
    $arch32 = "i386"
  } else {
    $arch32 = "i686"
  }
  if ! $::user_exists_oracle {
    user { "oracle":
      uid        => 500,
      gid        => 500,
      ensure     => present,
      managehome => true,
    }
  }
  group { "oinstall":
    gid        => 501,
    ensure     => "present",
  }
  package { "redhat-lsb":
    ensure    => present,
  }
  if $operatingsystemrelease !~ /5/ {  
    package { "terminus-fonts-console":
      ensure    => present,
    }
    package { "terminus-fonts":
      ensure    => present,
    }
    package { "tigervnc-server":
      ensure    => present,
    }
    package { "compat-libcap1":
      ensure    => latest,
    }
  }
  package { "binutils":
    ensure    => present,
  }
  package { "compat-libstdc++-33.x86_64":
    ensure    => latest,
  }
  package { "compat-libstdc++-33.$arch32":
    ensure    => latest,
  }
  package { "elfutils-libelf":
    ensure    => present,
  }
  package { "elfutils-libelf-devel":
    ensure    => present,
  }
  package { "gcc":
    ensure    => present,
  }
  package { "gcc-c++":
    ensure    => present,
  }
  package { "glibc.i686":
    ensure    => present,
  }
  package { "glibc-common":
    ensure    => present,
  }
  package { "glibc-devel":
    ensure    => present,
  }
  package { "glibc-devel.$arch32":
    ensure    => present,
  }
  package { "glibc-headers":
    ensure    => present,
  }
  package { "ksh":
    ensure    => present,
  }
  package { "libaio":
    ensure    => latest,
  }
  package { "libaio.$arch32":
    ensure    => latest,
  }
  package { "libaio-devel":
    ensure    => latest,
  }
  package { "libgcc":
    ensure    => present,
  }
  package { "libgcc.$architecture":
    ensure    => present,
  }
  package { "libstdc++":
    ensure    => present,
  }
  package { "libstdc++.$arch32":
    ensure    => present,
  }
  package { "libstdc++-devel":
    ensure    => present,
  }
  package { "make":
    ensure    => present,
  }
  package { "sysstat":
    ensure    => present,
  }
  package { "libXtst-devel.$arch32":
    ensure    => latest,
  }
  package { "libXrender-devel.$arch32":
    ensure    => latest,
  }
  exec { 'yum Group Install':
    unless  => '/usr/bin/yum grouplist "Desktop" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Desktop"',
  }
  package { "firefox":
    ensure    => latest,
  }
  if $operatingsystemrelease !~ /5/ {  
    package { "PackageKit-device-rebind":
      ensure    => present,
    }
    package { "gnome-packagekit":
      ensure    => present,
    }
    package { "PackageKit-gstreamer-plugin":
      ensure    => present,
    }
    package { "PackageKit-gtk-module":
      ensure    => present,
    }
    package { "PackageKit-glib":
      ensure    => present,
    }
    package { "PackageKit-yum":
      ensure    => present,
    }
    package { "PackageKit":
      ensure    => present,
    }
    package { "PackageKit-yum-plugin":
      ensure    => present,
    }
  }
  package { "xorg-x11-server-Xvfb":
    ensure    => present,
  }
  package { "xorg-x11-utils":
    ensure    => present,
  }
 # service { "xvfbebs":
 #   ensure    => stopped,
 #   enable    => false,
 # } 
  service { "atd":
    ensure    => stopped,
    enable    => false,
  }
  service { "autofs":
    ensure    => stopped,
    enable    => false,
  }
  service { "cups":
    ensure    => stopped,
    enable    => false,
  }
  service { "nfslock":
    ensure    => stopped,
    enable    => false,
  }
  service { "iptables":
    ensure    => stopped,
    enable    => false,
  }
  service { "ip6tables":
    ensure    => stopped,
    enable    => false,
  }
#  service { "vncserver":
#    ensure    => running,
#    enable    => true,
#   require   => File["vncservers"],
#  }
  file { 'u00':
    path      => '/u00',
    ensure    => directory,
    owner     => oracle,
    group     => dba,
    mode      => 775,
  }
  file { 'u00/oracle':
    path      => '/u00/oracle',
    ensure    => directory,
    owner     => oracle,
    group     => dba,
    mode      => 775,
  }
  if $hostname =~ /odsysrvsdb/ {
    file { 'limits.conf':
      path    => '/etc/security/limits.conf',
      ensure  => file,
      source  => "puppet:///modules/example/oracle-limits.conf-odsy"
    }
    file { 'sysctl.conf':
      path      => '/etc/sysctl.conf',
      ensure    => file,
      source    => "puppet:///modules/example/oracle-sysctl.conf-odsy"
    }
  } else {
    file { 'limits.conf':
      path      => '/etc/security/limits.conf',
      ensure    => file,
      source    => "puppet:///modules/example/oracle-limits.conf"
    }
    file { 'sysctl.conf':
      path      => '/etc/sysctl.conf',
      ensure    => file,
      source    => "puppet:///modules/example/oracle-sysctl.conf"
    }
  }
  exec { "/sbin/sysctl -p":
    subscribe   => File["/etc/sysctl.conf"],
    refreshonly => true
  }
  file { 'vncservers':
    path      => '/etc/sysconfig/vncservers',
    ensure    => file,
    mode      => 0644,
    owner     => root,
    group     => root,
    source    => "puppet:///modules/example/oracle-vncserver-displays",
  }
#  file { '.vnc':
#    path      => '/home/oracle/.vnc',
#    ensure    => directory,
#    owner     => oracle,
#    group     => dba,
#    recurse   => true,
#  }
#  file { 'xstartup':
#    path      => '/home/oracle/.vnc/xstartup',
#    ensure    => file,
#    owner     => oracle,
#    group     => dba, source    => "puppet:///modules/example/oracle-xstartup",
#    mode      => 0755,
#    require   => File[".vnc"]
#  }
#  file { 'passwd':
#    path      => '/home/oracle/.vnc/passwd',
#    ensure    => file,
#    owner     => oracle,
#    group     => dba,
#    source    => "puppet:///modules/example/oracle-vncpasswd",
#    mode      => 0600,
#    require   => File[".vnc"]
#  }
# file { 'inittab':
#   path      => '/etc/inittab',
#    ensure    => file,
#    owner     => root,
#    group     => root,
#    source    => "puppet:///modules/example/oracle-inittab",
#    mode      => 0644,
# }
#  file { 'xvfbebs':
#    path      => '/etc/init.d/xvfbebs',
#    ensure    => file,
#    owner     => root,
#    group     => root,
#    source    => "puppet:///modules/example/oracle-xvfbebs",
#    mode      => 0755,
#  }
}
class example::oracle::nfs::stage {
  file { 'stage':
    path     => '/stage',
    ensure   => directory,
    owner    => oracle,
    group    => dba,
    mode     => 0775,
  }
  mount { "/stage":
    #device   => "10.16.60.77:/ifs/space/oracle",
    device   => "isilon01.example.com:/ifs/space/oracle",
    fstype   => "nfs",
    ensure   => mounted,
    options  => "rw,bg,vers=3,proto=tcp,nolock,hard,nointr,rsize=65536,wsize=65536,actimeo=120,_netdev",
    atboot   => true,
    require  => [ Package['nfs-utils'], File['stage'] ],
  }
}
class example::oracle::nfs::exp {
  file { 'exp':
    path      => '/exp',
    ensure    => directory,
    owner     => oracle,
    group     => dba,
    mode      => 0775,
  }
  mount { "/exp":
    device   => "isilon01.example.com:/ifs/aaexpvol",
    fstype   => "nfs",
    ensure   => mounted,
    options  => "rw,bg,vers=3,proto=tcp,hard,nointr,rsize=65536,wsize=65536,nolock,actimeo=0",
    #options  => "rw,bg,vers=3,proto=tcp,hard,nointr,rsize=32768,wsize=32768,nolock,actimeo=600",
    atboot   => true,
    require  => [ Package['nfs-utils'], File['exp'] ],
  }
}
class example::oracle::nfs::arch {
  file { 'arch':
    path     => '/arch',
    ensure   => directory,
    owner    => oracle,
    group    => dba,
    mode     => 0775,
  }
  mount { "/arch":
    device   => "isilon01.example.com:/ifs/arch",
    fstype   => "nfs",
    ensure   => mounted,
    options  => "rw,bg,vers=3,proto=tcp,_netdev,nolock,hard,nointr,rsize=65536,wsize=65536,actimeo=0",
    atboot   => true,
    require  => [ Package['nfs-utils'], File['arch'] ],
  }
}
class example::oracle::u01 {
  file { 'u01':
    path     => '/u01',
    ensure   => directory,
    owner    => oracle,
    group    => dba,
    mode     => 0775,
#    recurse  => true,
  }
}
class example::oracle::sudoers {
  file { 'sudoers':
    path     => '/etc/sudoers.d/20-oracle',
    ensure   => file,
    owner    => root,
    group    => root,
    mode     => 0440,
    source    => "puppet:///modules/example/oracle-sudoers",
  }
}

class example::oracle::fonts {
  package { 'xorg-x11-server-Xvfb':
    ensure   => latest,
  }
}

class example::oracle::app::sudoers {
  file { 'app-sudoers':
    path     => '/etc/sudoers.d/21-oracle-app',
    ensure   => file,
    owner    => root,
    group    => root,
    mode     => 0440,
    source   => "puppet:///modules/example/oracleapp-sudoers",
  }
}
