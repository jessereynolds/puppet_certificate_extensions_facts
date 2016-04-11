# Puppet Certificate Extensions Facts

This puppet module provides a custom fact to include all puppet certificate extensions as facts. This allows console based clasification of nodes based on 'trusted' facts embedded in the certificate by making these available as regular facts.

Facts added correspond to each of the X509 certificate extensions
under Puppet's ppRegCertExt oid namespace, `1.3.6.1.4.1.34380.1.1`. When there are short names defined in
the puppet agent code in `Puppet::SSL::Oids::PUPPET_OIDS` the facts will appear with
the short names as the fact names. Eg:

```
$ facter pp_instance_id
i-8da75c11
```

They will also always appear as facts named with the oid prefixed with `certificate_extension_`, and with periods translated to underscores Eg:

```
$ facter certificate_extension_1_3_6_1_4_1_34380_1_1_2
i-8da75c11
```

See [the docs](https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html#puppet-specific-registered-ids) for the list of oids with short names defined in the puppet agent.

Author: Jesse Reynolds; Puppet, Inc.

This fact is subject to the license of this module as per the LICENSE file.

