require 'facter'
Facter.add(:user_exists_infraadm) do
  setcode do
    name = "infraadm"
    Facter::Util::Resolution.exec("/usr/bin/id -u #{name} 2>/dev/null")
  end
end
