
class example::ci::base {
  include example::devops::users
}

#class example::ci::users {
#  include accounts
#  realize (Accounts::Virtual['jaime'])
#  realize (Accounts::Virtual['tyrion'])
#  realize (Accounts::Virtual['arete'])
#}
