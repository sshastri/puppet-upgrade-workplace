class example::service-account {
  # User account 
  user { "hadoop":
    ensure     => present,
    managehome => true,
    uid        => 600,
  }
}
