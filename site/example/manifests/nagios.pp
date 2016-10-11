# Class for Nagios Server
class example::nagios::monitor {
  service { naemon:
    ensure => running,
    enable => true,
    #subscribe => File[$nagios_cfgdir],
  }
  Nagios_host <<||>> { notify => Service["naemon"] }
  Nagios_service <<||>> { notify => Service["naemon"] }
}

class example::nagios::target {
  @@nagios_host { $fqdn:
    ensure => present,
    alias => $hostname,
    address => $fqdn,
    use => "linux-server",
  }
  @@nagios_service { "check_ping_${hostname}":
    ensure => present,
    check_command => "check_ping!100.0,20%!500.0,60%",
    use => "generic-service",
    host_name => "$fqdn",
    notification_period => "24x7",
    service_description => "ping"
  }
  if ($kernel == "Linux") {
    @@nagios_service { "check_ssh_${hostname}":
      ensure => present,
      check_command => "check_ssh",
      use => "generic-service",
      host_name => "$fqdn",
      notification_period => "24x7",
      service_description => "ssh",
    }
  }   
}
