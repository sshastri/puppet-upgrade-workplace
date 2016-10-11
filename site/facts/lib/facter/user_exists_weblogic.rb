require 'facter'
Facter.add(:user_exists_weblogic) do
  setcode do
    name = "weblogic"
    Facter::Util::Resolution.exec("/usr/bin/id -u #{name} 2>/dev/null")
  end
end
