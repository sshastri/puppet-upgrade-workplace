require 'facter'
Facter.add(:user_exists_oracle) do
  setcode do
    name = "oracle"
    Facter::Util::Resolution.exec("/usr/bin/id -u #{name} 2>/dev/null")
  end
end
