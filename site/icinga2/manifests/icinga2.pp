# Configure PagerDuty Alerting Service
#
# Template Examples:
# http://monitoring-portal.org/wbb/index.php?page=Thread&postID=204321
# https://lists.icinga.org/pipermail/icinga-users/2014-May/008201.html
class icinga2::pagerduty (
  $pagerduty_service_apikey = 6c77fde0b592465ca442a17144ba8191,
) {

  include stdlib

  # Install Perl dependencies
  $pagerduty_dependencies_packages = [ 'perl-libwww-perl', 'perl-Crypt-SSLeay' ]
  ensure_packages ( $pagerduty_dependencies_packages )

  # Install PagerDuty Alerting Script
  file { 'pagerduty_icinga.pl':
    ensure  => file,
    path    => '/etc/icinga2/scripts/pagerduty_icinga.pl',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('icinga2/pagerduty_icinga.pl.erb'),
  }

  # Create PagerDuty Icinga User
  icinga2::object::user { 'pagerduty':
    display_name => 'PagerDuty Notification User',
    pager        => $pagerduty_service_apikey,
    target_dir   => '/etc/icinga2/objects/users',
    states       => [ 'OK', 'Critical' ],
  }

  ## Configure Cron for Icinga User
  cron { 'icinga pagerduty':
    ensure   => present,
    command  => '/usr/local/bin/pagerduty_icinga.pl flush',
    user     => 'icinga',
    minute   => '*',
    hour     => '*',
    monthday => '*',
    month    => '*',
    weekday  => '*',
  }

  ## Configure Icinga2 PagerDuty Notification Command for Service
  icinga2::object::notificationcommand { 'notify-service-by-pagerduty':
    command            => ['"/icinga2/scripts/pagerduty_icinga.pl"', '"enqueue"', '"-f"', '"pd_nagios_object=service"', '"--verbose"'],
    cmd_path           => 'SysconfDir',
    template_to_import => 'plugin-notification-command',
    env                         => {
      '"ICINGA_CONTACTPAGER"'     => '"$user.pager$"',
      '"ICINGA_NOTIFICATIONTYPE"' => '"$notification.type$"',
      '"ICINGA_SERVICEDESC"'      => '"$service.name$"',
      '"ICINGA_HOSTNAME"'         => '"$host.name$"',
      '"ICINGA_HOSTALIAS"'        => '"$host.display_name$"',
      '"ICINGA_SERVICESTATE"'     => '"$service.state$"',
      '"ICINGA_SERVICEOUTPUT"'    => '"$service.output$"',
    },
  }

  ## Configure Icinga2 PagerDuty Notification Command for Hosts
  icinga2::object::notificationcommand { 'notify-host-by-pagerduty':
    command            => ['"/icinga2/scripts/pagerduty_icinga.pl"', '"enqueue"', '"-f"', '"pd_nagios_object=host"', '"--verbose"'],
    cmd_path           => 'SysconfDir',
    template_to_import => 'plugin-notification-command',
    env                         => {
      '"ICINGA_CONTACTPAGER"'     => '"$user.pager$"',
      '"ICINGA_NOTIFICATIONTYPE"' => '"$notification.type$"',
      '"ICINGA_HOSTNAME"'         => '"$host.name$"',
      '"ICINGA_HOSTALIAS"'        => '"$host.display_name$"',
      '"ICINGA_HOSTSTATE"'        => '"$host.state$"',
      '"ICINGA_HOSTOUTPUT"'       => '"$host.output$"',
    },
  }

  ## Configure Apply Notification to Hosts
  icinga2::object::apply_notification_to_host { 'pagerduty-host':
    assign_where => 'host.vars.enable_pagerduty == "true"',
    command      => 'notify-host-by-pagerduty',
    users        => [ 'pagerduty' ],
    states       => [ 'Up', 'Down' ],
    types        => [ 'Problem', 'Acknowledgement', 'Recovery', 'Custom' ],
    period       => '24x7',
  }

  ## Configure Apply Notification to Services
  icinga2::object::apply_notification_to_service { 'pagerduty-service':
    assign_where => 'service.vars.enable_pagerduty == "true"',
    command      => 'notify-service-by-pagerduty',
    users        => [ 'pagerduty' ],
    states       => [ 'OK', 'Warning', 'Critical', 'Unknown' ],
    types        => [ 'Problem', 'Acknowledgement', 'Recovery', 'Custom' ],
    period       => '24x7',
  }
}
