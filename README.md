# puppet-kitchen-example

I need a test environment for a puppet server, so why not harness the power of vagrant? This will converge/create/launch/instantiate a working puppet server when you: `kitchen converge default-centos-65` 

This will port forward 8140 to your host's 8140, so now you're serving off a puppet server to your host's network/subnet.

To register your host's puppet client against your vagrant'ized puppet server: 





inspired from: http://ehaselwanter.com/en/blog/2014/05/08/using-test-kitchen-with-puppet/
