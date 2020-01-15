# Minikube on Openstack Fedora 31 via Vagrant

## Usage

1. Install vagrant openstack plugin `vagrant plugin install vagrant-openstack-provider`
1. Authenticate via Openstack's OpenRC 3. In web console go: _Project_ >> 
   _API Access_ >> Download _OpenStack RC File (Identity API v3)_)
1. Run `vagrant up`. Login via `vagrant ssh` and destroy VM with `vagrant destroy`. 
   Check status with `vagrant status`

