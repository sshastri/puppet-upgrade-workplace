class example::splunk::forwarder {
  notify { 'Will deploy, configure and enable splunk forwarder.': }
  package{"splunkforwarder":
    ensure  => installed
  }

  exec {"splunk_UF_enable_boot_start_accept_license":
    command => "/opt/splunkforwarder/bin/splunk enable boot-start --accept-license  --no-prompt  --answer-yes && /opt/splunkforwarder/bin/splunk start",
    require => Package["splunkforwarder"],
  }

  file { "/opt/splunkforwarder/etc/system/local/outputs.conf" :
    ensure  => file,
    require => Package["splunkforwarder"],
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    content => "[tcpout: my_LB_indexers]
          disabled=false
          autoLBFrequency=40
          server=splunk01.example.com:9997,splunk02.example.com:9997",
  }

#  file { "/opt/splunkforwarder":
#    ensure => "directory",
#    owner  => "root",
#    group  => "root",
#    mode   => 700,
#    require => Package["splunkforwarder"],
# }
}
