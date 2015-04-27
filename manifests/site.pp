
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


#file { "/etc/puppet/hiera.yaml":
#  ensure => "file",
#  content => template("puppetmasterplayground/hiera.yaml.erb"),
#}


#class { 'puppetdb':
#  listen_address => 'default-centos-65.vagrantup.com'
#}
#->
#class { 'puppetdb::master::config':
#}



