# User to define/realize users on Puppet-managed systems
#
############################################################
# Admin Accounts
############################################################
class accounts {

  @accounts::virtual { 'melanthius':
    uid             => 721400105,
    gid             => 721400105,
    realname        => 'melanthius',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'melantho':
    uid             => 721400112,
    gid             => 721400112,
    realname        => 'Melantho',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'calypso':
    uid             => 721400111,
    gid             => 721400111,
    realname        => 'Calypso',
    pass            => '',
    sshkeytype      => 'ssh-dss',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'travis':
    uid             => 721400088,
    gid             => 721400088,
    realname        => 'Travis',
    pass            => '',
    sshkeytype      => 'ssh-dss',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'alan':
    uid             => 721400007,
    gid             => 721400007,
    realname        => 'Alan',
    pass            => '',
    sshkeytype      => 'ssh-dss',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'polyphemus':
    uid             => 721400160,
    gid             => 721400160,
    realname        => 'Polyphemus',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
  @accounts::virtual { 'circe':
    uid             => 721400164,
    gid             => 721400164,
    realname        => 'Circe',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }

############################################################
# DBA Accounts
############################################################
  @accounts::virtual { 'Zeus':
    uid             => 721400046,
    gid             => 721400046,
    realname        => 'Zeus',
    pass            => '',
    sshkeytype      => 'ssh-dss',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Penelope':
    uid             => 721400033,
    gid             => 721400033,
    realname        => 'Penelope',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
  @accounts::virtual { 'odysseus':
    uid             => 721400070,
    gid             => 721400070,
    realname        => 'odysseus',
    pass            => '',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Eumaeus':
    uid             => 721400153,
    gid             => 721400153,
    realname        => 'Eumaeus',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Poseidon':
    uid             => 721400091,
    gid             => 721400091,
    realname        => 'poseiden',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Telemachus':
    uid             => 721400075,
    gid             => 721400075,
    realname        => 'Telemachus',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Athena':
    uid             => 721400047,
    gid             => 721400047,
    realname        => 'Athena',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dba"],
  }
# Temp Account per UNIX-1536
  @accounts::virtual { 'Antinous':
    uid             => 721400400,
    gid             => 721400400,
    realname        => 'Antinous',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Eurymachus':
    uid             => 721400401,
    gid             => 721400401,
    realname        => 'Eurymachus',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["dba"],
  }
  @accounts::virtual { 'Amphinomus':
    uid             => 721400402,
    gid             => 721400402,
    realname        => 'Amphinomus',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["dba"],
  }

############################################################
# ERP accounts
############################################################
  @accounts::virtual { 'laertes':
    uid             => 721400162,
    gid             => 721400162,
    realname        => 'Laertes',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["erp"],
  }
  @accounts::virtual { 'tiresias':
    uid             => 721400166,
    gid             => 721400166,
    realname        => 'Tiresias',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["erp"],
  }
  @accounts::virtual { 'nestor':
    uid             => 721400121,
    gid             => 721400121,
    realname        => 'Nestor',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["erp"],
  }
  @accounts::virtual { 'menelaus':
    uid             => 721400122,
    gid             => 721400122,
    realname        => 'Menelaus',
    pass            => 'REDACTED',
    sshkeytype      => '',
    sshkey          => '',
    groups          => ["erp"],
  }
############################################################
# Release Team
############################################################

############################################################
# Developer accounts
############################################################
  @accounts::virtual { 'helen':
    uid             => 721400040,
    gid             => 721400040,
    realname        => 'Helen',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dev","tomcat"],
  }
  @accounts::virtual { 'Eurycleia':
    uid             => 721400074,
    gid             => 721400074,
    realname        => 'Eurycleia',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dev","tomcat"],
  }
  @accounts::virtual { 'agamemnon':
    uid             => 721400200,
    gid             => 721400200,
    realname        => 'Agamemnon',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dev","tomcat"],
  }
  @accounts::virtual { 'nausicaa':
    uid             => 721400201,
    gid             => 721400201,
    realname        => 'Nausicaa',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dev","tomcat"],
  }
  @accounts::virtual { 'alcinous':
    uid             => 721400202,
    gid             => 721400202,
    realname        => 'Alcinous',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["dev","tomcat"],
  }

############################################################
# Build Team accounts
############################################################
  @accounts::virtual { 'arete':
    uid             => 721400081,
    gid             => 721400081,
    realname        => 'Arete',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["devops"],
  }
  @accounts::virtual { 'tyrion':
    uid             => 721400148,
    gid             => 721400148,
    realname        => 'Tyrion Lannister',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["devops"],
  }
  @accounts::virtual { 'jaime':
    uid             => 721400149,
    gid             => 721400149,
    realname        => 'Jaime Lannister',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["devops"],
  }

############################################################
# System accounts
############################################################
  @accounts::virtual { 'svc-nexpose':
    uid             => 55002,
    gid             => 55002,
    realname        => 'Nexpose User',
    pass            => '',
    sshkeytype      => 'ssh-rsa',
    sshkey          => 'REDACTED',
    groups          => ["wheel"],
  }
#  @accounts::virtual { 'oracle':
#    uid             => 500,
#    gid             => 54321,
#    realname        => 'Oracle User',
#    pass            => 'REDACTED',
#    sshkeytype      => '',
#    sshkey          => '',
#    groups          => ["dba"],
#  }


}
