# Compliance nodes

node /odysseyprod/ {
  include example::base::config
  include example::compliance
  include example::base::snmp
}

node 'slc-erpappprod1.example.com' {
  include example::base::config
  include example::dba::users
  include example::compliance
  include example::base::snmp
}

node /slc-syslog1/ {
  include example::base::config
  include example::compliance
  include example::base::snmp
}

node /odysseydbprod1/ {
  include example::base::config
  include example::dba::users
  include example::compliance
  include example::base::snmp
}

node /creondbprod1/ {
  include example::splunk::forwarder
  include example::base::config
  include example::compliance
  include example::base::snmp
}

node /demantradbprod1/ {
  include example::splunk::forwarder
}

node /soadbprod1/ {
  include example::splunk::forwarder
}

node /uedwdbprod1/ {
  include example::base::config
  include example::compliance
  include example::base::snmp
  include example::iscsi::base
}

node /rigel/ {
  include example::base::config
  include example::dba::users
  include example::compliance
  include example::base::snmp
}

node /etldbprod1/ {
  include example::base::config
  include example::compliance
  include example::base::snmp
  include example::iscsi::base
}

node /boboprod1/ {
  include example::splunk::forwarder
  include example::base::config
  include example::compliance
  include example::base::snmp
  include example::dba::users
}

node /bodiprod1/ {
  include example::splunk::forwarder
  include example::base::config
  include example::compliance
  include example::base::snmp
}

node /shopprod/ {
  include example::shopnodes::logrotate
  include example::base::config
  include example::compliance
  include example::base::snmp
  file { 'sudoers':
    path   => '/etc/sudoers.d/11-security',
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 0440,
    source => "puppet:///modules/example/security-sudoers",
  }

}
