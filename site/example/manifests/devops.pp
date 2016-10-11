# DEVOPS classes
class example::devops::base {
  include accounts
  if $hostname =~ /webemaildev/ or $hostname =~ /webemailtest/ or $hostname =~ /webemailstage/ {
    include example::devops::users
  } else {
    user { arete:
      ensure     => absent,
    }
  }

#  file { "/etc/sudoers.d/devops":
#    mode    => 440,
#    owner   => root,
#    group   => root,
#    source  => "puppet:///modules/example/devops-sudoers"
#  }
}

class example::devops::users {
  include accounts
  realize (Accounts::Virtual['jaime'])
  realize (Accounts::Virtual['tyrion'])
  realize (Accounts::Virtual['arete'])
  group { "devops":
    gid    => 50001,
    ensure => "present",
  }
  file { "/etc/sudoers.d/devops":
    mode    => 440,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/example/devops-sudoers"
  }
}

class example::devops::deploy::sudo {
  file { '/etc/sudoers.d/deploy':
    content => "Defaults:deploy !requiretty\ndeploy ALL=(ALL) NOPASSWD: ALL\n",
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
  }
}
