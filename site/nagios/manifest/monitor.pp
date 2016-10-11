class nagios::monitor {
  service { naemon:
    ensure => running,
    enable => true,
    #subscribe => File[$nagios_cfgdir],
  }
  Nagios_host <<||>>
  Nagios_service <<||>>
}
