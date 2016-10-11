class example::compliance {
  file { "/etc/pam.d/system-auth-ac":
    mode    => 644,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/example/compliance-system-auth"
  }
  file { "/etc/login.defs":
    mode    => 644,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/example/login.defs"
  }
}
