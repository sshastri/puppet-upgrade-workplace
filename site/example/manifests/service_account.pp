class example::service_account {
  # User account 
  user { "hadoop":
    ensure     => present,
    managehome => true,
    uid        => 600,
  }
}
