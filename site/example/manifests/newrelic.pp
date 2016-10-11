# newrelic plugin install
class { 'newrelic_plugins::base':
  license_key  => '',
  install_path => '/usr/local',
  user         => 'newrelic'
}
