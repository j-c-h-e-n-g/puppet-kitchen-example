
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


