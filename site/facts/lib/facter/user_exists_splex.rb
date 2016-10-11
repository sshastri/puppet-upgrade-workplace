require 'facter'
Facter.add(:user_exists_splex) do
  setcode do
    name = "splex"
    Facter::Util::Resolution.exec("/usr/bin/id -u #{name} 2>/dev/null")
  end
end
