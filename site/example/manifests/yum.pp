class example::yum::update
{
# Run a yum update on the 6th of every month between 11:00am and 11:59am.
# Notes: A longer timout is required for this particular run,
#        The time check can be overridden if a specific file exists in /var/tmp
  exec { "monthly-yum-update":
    command => "/usr/bin/yum clean all; /usr/bin/yum -q -y update;",
    timeout => 1800,
    onlyif => "/usr/bin/test -e /var/tmp/forceyum",
#    onlyif => "/usr/bin/test `/bin/date +%d` -eq 06 && test `/bin/date +%H` -eq 11 || test -e /var/tmp/forceyum",
  }
}
