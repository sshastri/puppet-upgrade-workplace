class example::base::snmp {
  package { "net-snmp":
    ensure  => latest,
  }
  service { "snmpd":
    ensure  => "running",
    enable  => "true",
    require => Package["net-snmp"],
  }
  file { "/etc/snmp/snmpd.conf":
    notify  => Service["snmpd"],
    mode    => 644,
    owner   => root,
    group   => root,
    require => Package["net-snmp"],
    source  => "puppet:///modules/example/snmpd.conf"
  }
}
