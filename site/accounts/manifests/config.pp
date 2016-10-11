class accounts::config {

  # Place the /etc/skel files in the users home dir.
  file { '/etc/skel/.bash_profile':
    ensure         => present,
    source         => puppet://modules/config/skel/.bash_profile
    mode           => '0644',
    owner          => '0',
    group          => '0',
  }
}
