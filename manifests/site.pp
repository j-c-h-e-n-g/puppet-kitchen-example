
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

file { "/etc/puppet/hiera.yaml":
  ensure => "file",
  content => "$hiera_content"
}


class { 'puppetdb':
  listen_address => 'default-centos-65.vagrantup.com'
}
->
class { 'puppetdb::master::config':
}



