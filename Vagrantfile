#!/usr/bin/env ruby

require 'vagrant-openstack-provider'

def env(name)
  raise "Environemntal variable #{name} is required to be set!" if ENV[name].nil?
  ENV[name]
end

Vagrant.configure('2') do |config|

  config.ssh.username = 'fedora'

  config.vm.provider :openstack do |os|
    os.server_name        = "minikube-1.17-#{env 'USER'}"
    os.openstack_auth_url = env 'OS_AUTH_URL'
    os.identity_api_version = '3'
    os.domain_name        = env 'OS_USER_DOMAIN_NAME'
    os.username           = env 'OS_USERNAME'
    os.password           = env 'OS_PASSWORD'
    os.project_name       = env 'OS_PROJECT_NAME'
    os.region             = env 'OS_REGION_NAME'
    os.flavor             = 'ci.m4.xlarge'
    os.image              = 'Fedora-Cloud-Base-31'
    os.networks           = 'provider_net_cci_2'
  end
end