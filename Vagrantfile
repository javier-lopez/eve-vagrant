VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise32'
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 2794, host: 2794
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.vm.provision 'shell', path: 'eve_precise32_provision.sh'
end

#  vim: set ts=8 sw=4 tw=0 ft=ruby :
