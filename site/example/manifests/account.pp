class example::account::removals {
  # User account removals
  user { "jasons01":
    ensure     => absent,
    managehome => true,
  }
  user { "brandonh03":
    ensure     => absent,
    managehome => true,
  }
  user { "jason.schuman":
    ensure     => absent,
    managehome => true,
  }
  user { "justin.scheurer":
    ensure     => absent,
    managehome => true,
  }
  user { "rubenp01":
    ensure     => absent,
    managehome => true,
  }
  user { "nagarjunay23":
    ensure     => absent,
    managehome => true,
  }
  user { "toto":
    ensure     => absent,
    managehome => true,
  }
  user { "aaronw23":
    ensure     => absent,
    managehome => true,
  }
  user { "thomas.silva":
    ensure     => absent,
    managehome => true,
  }
  user { "colinm15":
    ensure     => absent,
    managehome => true,
  }
  user { "williamk16":
    ensure     => absent,
    managehome => true,
  }
}
