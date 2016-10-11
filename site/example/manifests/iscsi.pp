class example::iscsi::base {
  package { iscsi-initiator-utils:
    ensure  => present,
  }
  package { device-mapper-multipath:
    ensure  => present,
  }
  service { multipathd:
    ensure  => running,
    enable  => true,
    require => File["multipath.conf"],
  }
  file { 'initiatorname.iscsi':
    path    => "/etc/iscsi/initiatorname.iscsi",
    content => template('example/initiatorname.iscsi-template'),
    require => Package["iscsi-initiator-utils"],
  }  
  file { 'multipath.conf':
    path    => "/etc/multipath.conf",
    source  => "puppet:///modules/example/multipath.conf-default",
    require => Package["device-mapper-multipath"],
    notify  => Service["multipathd"],
  }
  file { 'iscsid.conf':
    path    => "/etc/iscsi/iscsid.conf",
    source  => "puppet:///modules/example/iscsid.conf-default",
    require => Package["iscsi-initiator-utils"],
    notify  => Service["iscsid"],
  }
  service { iscsid:
    ensure  => running,
    enable  => true,
    require => File["initiatorname.iscsi"],
  }
  service { iscsi:
    ensure  => running,
    enable  => true,
    require => Service["iscsid"],
  }
}
