if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
node default {
  include example::base::config
#  include example::admin::users
#  user { root:
#   password   => '$6$47O3ls3Q$8EQh.zl9ldBhgmWvRBtP8bDrcKww61/oVVF1YnXcv0MyeuudfR2dVeFuI/nfXeH0XCNYGFKMiKq.YMr9sKOyQ0',
# }
}

