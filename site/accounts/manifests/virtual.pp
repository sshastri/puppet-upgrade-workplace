# Defined type for create virtual user accounts
#
#define accounts::virtual ($uid,$realname,$sshkeytype,$sshkey,$groups) {
define accounts::virtual ($uid,$gid,$realname,$pass,$sshkeytype,$sshkey,$groups) {
  include accounts::params

  # Pull in values from accounts::params
  $homepath = $accounts::params::homepath
  $shell = $accounts::params::shell

  # Create the user
  user { $title:
    ensure          => 'present',
    uid             => $uid,
#    if str2bool("$gid") {
       gid          => $gid,
#    } else {
#       gid          => $title,
#    }
    shell           => $shell,
    home            => "${homepath}/${title}",
    comment         => $realname,
    password        => $pass,
    managehome      => true,
    groups          => $groups,
    require         => Group[$title],
  }

  # Create a matching group
  group  { $title:
#    if str2bool("$gid") {
      gid           => $gid,
#    } else {
#      gid           => $uid,
#    }
  }

  # Ensure the home directory exists with the right permissions
  file { "${homepath}/${title}":
    ensure          => directory,
    owner           => $title,
    group           => $title,
    mode            => 0750,
    require         => [ User[$title], Group[$title] ],
  }

  # Ensure the .ssh directory exists with the right permissions
  file { "${homepath}/${title}/.ssh":
    ensure          => directory,
    owner           => $title,
    group           => $title,
    mode            => '0700',
    require         => File["${homepath}/${title}"],
  }

  # Add user's SSH key
  if ($sshkey != '') {
    ssh_authorized_key {$title:
      ensure        => present,
      name          => $title,
      user          => $title,
      type          => $sshkeytype,
      key           => $sshkey,
    }
  }
}
