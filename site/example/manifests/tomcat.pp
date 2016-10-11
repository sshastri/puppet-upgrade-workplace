class example::tomcat::user {
  user { tomcat:
    ensure     => "present",
    uid        => 501,
    gid        => 5001,
    shell      => '/bin/bash',
    managehome => true,
    password   => '',
  }
  group {tomcat:
    ensure     => present,
    gid        =>  5001,
  }  
  if $hostname =~ /webemaildev/ or $hostname =~ /webemailtest/ {
    ssh_authorized_key { 'bamboo-nonprod@jiraprod6.example.com':
      user        => 'tomcat',
      type        => 'ssh-rsa',
      key         => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC/OHvGCpUDgqOit7rpBuylzuyBbfdwRwADLjz2TRTPI/4ghUW4k5Q3t4x8rahWl3034f3TUKyAk9X+/suDZqgX9ZLUR68UbKNqCpgdLBrV6IFEuNR+N5WI/FfIJXMaDw9Lz1bfyTV6VvT/rcp3dV8bXPmDtRpAPJ/X3pADtdpwe1d7gV66AuA/N049ZKAqLYvp9gUMZIo2Y9G8LbFK1zmjNQwp+d7jqIW8z/Qwfd5Njukc8ko/R65rz//RNAnoVVEpgOQb+Xb3I1bp1I8p6nVJt6EbqJ2/70CT+ox4kTxpCAkIe+usYD99HSf77KEQrHp9igHWCJv6f1myU/4UaKUT',
    }
  } elsif $hostname =~ /webemailstage/ or $hostname =~ /webemailprod/ {
    ssh_authorized_key { 'bamboo-prod@jiraprod6.example.com':
      user        => 'tomcat',
      type        => 'ssh-rsa',
      key         => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCv8I1o8zkYVe/TIvu6SFJecvdx78AbqZYmujNjZOPuekkUWmR+U+mm0YmEEqWq0pU9EFXkZynA6oLNhjcOy61CyMkfmvz18mQ9x1WHGDB3G5LsDGEukQO1CAZbNdcRTnkAUYai1EUqrqFCFKlCIxISOVsnzmKmVFHLsGu+7yoZ2g5qb0BdKpDaJ0SGAe1UZhn2u8+KqES7v8v0gd90TNARsX2I/aKND3QxfRUmE39fsIOKZXaq6OKy/lAeMEPhZr1sPMSHBhBrgVhR1Oug8sDPt0muGBzCxAFOi9NKCPrIa0J/m4DC0T/+klwtJUWi3fqclHDqwZgGUoXexx9Giecf',
    }
  } else {
    ssh_authorized_key { 'tomcat@nobody':
      user        => 'tomcat',  
      type        => 'ssh-rsa',
      key         => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKnGBcCWx85SY375IUpgfKbc8EulDXnsUKR4lOpYbZPTgjqkJHacLIwkOq8d26y+vbGsPOIsXW99Lj2ApIfhCHy8sFTa4it7iT7KpCb/sJ03EtOSb+pmie1g9R703l0H0y/TrAhusH4oyIhstj/j4A/Lq5cC3BiWh9PBefEEIIGjxZytYQPhlJJJ2ctqN8+0Aa7Dt/rPlnXgSNeBTXbz3yRuX6+AnSyWl+wzcBHLtpn1GgOQ99K/vNFU8Iwa8O1IunwQ1yD/XXPTVKuKZpyCfMzLGdaUZkryNLzz4+oY6HR6ra+mnlB6icVvDL/Vx7571IdFsv0yarzOKgjUpr8qiz',
    }
  }
}
