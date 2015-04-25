## About

I need a test environment for a puppet server, so why not harness the power of vagrant? This will converge/create/launch/instantiate a working puppet server when you: `kitchen converge default-centos-65` 

This will port forward 8140 to your host's 8140, so now you're serving off a puppet server to your host's network/subnet.

## Usage

Let's say you want to register your host's puppet client against your vagrant'ized puppet server. In my case for my macbook I have in `/etc/hosts`: 

    127.0.0.1	localhost default-centos-65.vagrantup.com 

... so I then run: 

    $ puppet agent --test --server default-centos-65.vagrantup.com 
    Info: Creating a new SSL key for 5cf93894a556.local
    Info: Caching certificate for ca
    Info: csr_attributes file loading from /Users/asdf/.puppet/csr_attributes.yaml
    Info: Creating a new SSL certificate request for 5cf93894a556.local
    Info: Certificate Request fingerprint (SHA256):       
    6D:B8:78:4D:9E:54:36:35:0A:16:F6:F8:60:AA:B8:93:88:07:84:FA:E6:D7:68:45:70:D8:A9:A8:81:32:E0:2C
    Info: Caching certificate for ca
    Exiting; no certificate found and waitforcert is disabled


So on the vagrant'ized puppet server, you'll see the request: 
  
    # puppet cert --list
    "5cf93894a556.local" (SHA256) 6D:B8:78:4D:9E:54:36:35:0A:16:F6:F8:60:AA:B8:93:88:07:84:FA:E6:D7:68:45:70:D8:A9:A8:81:32:E0:2C
  
.. and sign `5cf93894a556.local`:

    # puppet cert sign 5cf93894a556.local
    Notice: Signed certificate request for 5cf93894a556.local
    Notice: Removing file Puppet::SSL::CertificateRequest 5cf93894a556.local at '/var/lib/puppet/ssl/ca/requests/5cf93894a556.local.pem'

... and back on the puppet client on my macbook (host for virtualbox):

    $ puppet agent --test --server default-centos-65.vagrantup.com 
    Info: Caching certificate for 5cf93894a556.local
    Info: Caching certificate_revocation_list for ca
    Info: Caching certificate for 5cf93894a556.local
    Info: Retrieving pluginfacts
    Info: Retrieving plugin
    Notice: /File[/Users/asdf/.puppet/var/lib/puppet]/ensure: removed
    Notice: /File[/Users/asdf/.puppet/var/lib/facter]/ensure: removed
    Info: Caching catalog for 5cf93894a556.local
    Info: Applying configuration version '1429988989'
    Notice: Finished catalog run in 0.01 seconds











inspired from: http://ehaselwanter.com/en/blog/2014/05/08/using-test-kitchen-with-puppet/
