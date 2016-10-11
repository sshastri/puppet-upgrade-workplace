#!/opt/puppet/bin/ruby
# Retrieves the list of classes in the production environment from the Puppet master

require 'net/http'
require 'uri'
require 'json'
require 'facter'
require 'puppet'

# Have puppet parse its config so we can call its settings
Puppet.initialize_settings

# Gather values and certificate paths for the HTTPS connection
http             = Net::HTTP.new(Facter.value('fqdn'),'8140')
http.use_ssl     = true
http.cert        = OpenSSL::X509::Certificate.new(File.read(Puppet[:hostcert]))
http.key         = OpenSSL::PKey::RSA.new(File.read(Puppet[:hostprivkey]))
http.ca_file     = Puppet[:localcacert]
http.verify_mode = OpenSSL::SSL::VERIFY_PEER


headers = { 'Accept' => 'application/json' }
uri     = '/puppet/v3/environment_classes?environment=production'

resp = http.get(uri, headers)
puts resp.body.inspect
if resp.is_a?(Net::HTTPSuccess)
  puts 'success'
  puts JSON.parse(resp.body).inspect
elsif
  puts 'failure'
end
