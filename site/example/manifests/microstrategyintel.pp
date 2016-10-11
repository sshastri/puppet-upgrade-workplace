class example::microstrategyintel::base {
  include example::microstrategyintel::nfs
  include example::microstrategyintel::users
  package { "xorg-x11-apps":
    ensure     => present,
  }
  package { "xorg-x11-xauth":
    ensure     => present,
  }
  package { "libXtst":
    ensure     => present,
  }
  package { "libXfont":
    ensure     => present,
  }
  package { "ttmkfdir":
    ensure     => present,
  }
  package { "unzip":
    ensure     => present,
  }
  package { "xorg-x11-fonts-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-cyrillic":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ethiopic":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-1-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-14-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-14-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-15-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-15-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-1-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-2-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-2-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-9-100dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-ISO8859-9-75dpi":
    ensure     => present,
  }
  package { "xorg-x11-fonts-misc":
    ensure     => present,
  }
  package { "xorg-x11-fonts-Type1":
    ensure     => present,
  }
  package { "xorg-x11-font-utils":
    ensure     => present,
  }
  package { "xterm":
    ensure     => present,
  }
  package { "ksh":
    ensure     => present,
  }
  package { "openldap-clients":
    ensure     => present,
  }
  package { "compat-libstdc++-33":
    ensure     => present,
  }
  package { "libXp":
    ensure     => present,
  }
  package { "elfutils-devel":
    ensure     => present,
  }
  package { "elfutils-libelf-devel":
    ensure     => present,
  }
  package { "libstdc++":
    ensure     => present,
  }
  package { "krb5-libs":
    ensure     => present,
  }
  package { "nss-pam-ldapd":
    ensure     => present,
  }
  package { "compat-openldap":
    ensure     => present,
  }
  if $hostname =~ /intelapp/ {
    include example::iscsi::base
  }
    file { "/u01":
      ensure   => directory,
      owner    => "mstr",
      group    => "mstr",
      mode     => 0775,
    }
}
class example::microstrategyintel::users {
  user { "mstr":
    ensure     => present,
    uid        => 700,
    managehome => true,
    password   => '$6$wxnkibvj$rB8dFFYQc6cmuHs1uMaHytIDgnmVy6ujQF.2rXYM7p7Qe3JRtnFVT/MpEbL8sE8IwmgPXAaT2nljKNwtgZp480',
  }
  file { "/etc/sudoers.d/50_mstr":
    ensure     => file,
    owner      => root,
    group      => root,
    mode       => 0664,
    content    => "mstr\tALL=(ALL)\tNOPASSWD: ALL\n",
  }
}
class example::microstrategyintel::nfs {
  file { 'bistage':
    path     => '/bistage',
    ensure   => directory,
    owner    => mstr,
    group    => mstr,
    mode     => 0775,
   }
   mount { "/bistage":
    device   => "nfsprod1.example.com:/nfs/bistage",
    fstype   => "nfs",
    ensure   => mounted,
    options  => "rw,bg,vers=3,proto=tcp,nolock,hard,nointr,rsize=65536,wsize=65536,actimeo=120,_netdev",
    atboot   => true,
    require  => [ Package['nfs-utils'], File['bistage'] ],
   }
}
