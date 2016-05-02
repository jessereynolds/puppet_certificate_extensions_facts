# This adds custom facts that correspond to each of the X509 certificate extensions
# under Puppet's ppRegCertExt oid namespace, "1.3.6.1.4.1.34380.1.1". When there are short names defined in
# the puppet agent code in Puppet::SSL::Oids::PUPPET_OIDS the facts will appear with
# the short names as the fact names. Eg:
#
#   $ facter pp_instance_id
#   i-8da75c11
#
# They will also always appear as facts named with oid prefixed with 'certificate_extension_', and with periods translated to underscores Eg:
#
#   $ facter certificate_extension_1_3_6_1_4_1_34380_1_1_2
#   i-8da75c11
#
# See https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html#puppet-specific-registered-ids for the list of oids with short names defined in the puppet agent.
#
# Author: Jesse Reynolds; Puppet, Inc.
#
# This fact is subject to the license of this module as per LICENSE.md

require 'openssl'
require 'puppet'
require 'puppet/ssl/oids'

# is there a more elegant way of ascertaining if Puppet settings have been initialized already?
# (or should we assume they have been?)
begin
  ssldir = Puppet.settings[:ssldir]
rescue
  Puppet.initialize_settings
  ssldir = Puppet.settings[:ssldir]
end

# Failing that, also try initialising settings if ssldir is empty
unless ssldir && ssldir != ''
  Puppet.initialize_settings unless ssldir
  ssldir = Puppet.settings[:ssldir]
end

certname = Puppet.settings[:certname]

oids = {}
Puppet::SSL::Oids::PUPPET_OIDS.each {|o|
  oids[o[0]] = o[1]
}

raw = File.read("#{ssldir}/certs/#{certname}.pem")

cert = OpenSSL::X509::Certificate.new(raw)

cert.extensions.each {|e|
  short_name = nil
  case e.oid
  when /^1\.3\.6\.1\.4\.1\.34380\.1\.1/
    oid_name = "certificate_extension_#{e.oid.gsub(/\./, '_')}"
    Facter.add(oid_name) do
      setcode do
        e.value[2..-1]
      end
    end
    short_name = oids[e.oid]
  when /^pp_/
    short_name = e.oid
  end
  next unless short_name
  Facter.add(short_name) do
    setcode do
      e.value[2..-1]
    end
  end
}
