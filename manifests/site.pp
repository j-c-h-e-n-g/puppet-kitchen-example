# this is just to provide a boostrapped puppet environment for testing. 
# a playground environment to level up with 


# assumes puppetlabs-ntp module, so Puppetfile should have an entry for this! 
class { '::ntp':
  servers => [ '0.pool.ntp.org', '1.pool.ntp.org' ],
}

package {["tree", "puppet-server"]: 
  ensure => installed, 
} 
->
service {"puppetmaster": 
  ensure => running, 
  enable => true, 
  hasrestart => true, 
} 

file { "/etc/puppet/hieradata":
  ensure => "directory",
}

$hiera_content = '
---
:backends:
  - yaml
:yaml:
  :datadir: /etc/puppet/hieradata
:hierarchy:
  - "node/%{::fqdn}"
  - common
'

file { "/etc/hiera.yaml":
  ensure => "file",
  content => "$hiera_content"
}




class { 'puppetdb':
  listen_address => 'default-centos-65.vagrantup.com'
}
->
class { 'puppetdb::master::config':
}
