# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

IP1 = "10.0.3.3"
CLUSTER_IP1 = "192.168.100.3"
IP2 = "10.0.3.4"
CLUSTER_IP2 = "192.168.100.4"
IP3 = "10.0.3.5"
CLUSTER_IP3 = "192.168.100.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.define "node-1" do |node1|
		node1.vm.network "private_network", ip: IP1
		node1.vm.network "private_network", ip: CLUSTER_IP1
		node1.vm.synced_folder ".", "/vagrant", nfs: true

		node1.vm.provision "puppet" do |puppet|
			puppet.module_path = "modules"
			puppet.manifests_path = "manifests"
			puppet.manifest_file = "node1.pp"
			puppet.hiera_config_path = "hiera_node1.yaml"
			puppet.facter = {
				"cluster_ip" => CLUSTER_IP1,
				"ip1" => CLUSTER_IP1,
				"ip2" => CLUSTER_IP2,
				"ip3" => CLUSTER_IP3,
			}
		end
	end

	config.vm.define "node-2" do |node2|
		node2.vm.network "private_network", ip: IP2
		node2.vm.network "private_network", ip: CLUSTER_IP2
		node2.vm.synced_folder ".", "/vagrant", nfs: true

		node2.vm.provision "puppet" do |puppet|
			puppet.module_path = "modules"
			puppet.manifests_path = "manifests"
			puppet.manifest_file = "node2.pp"
			puppet.hiera_config_path = "hiera_node2.yaml"
			puppet.facter = {
				"cluster_ip" => CLUSTER_IP2,
				"ip1" => CLUSTER_IP1,
				"ip2" => CLUSTER_IP2,
				"ip3" => CLUSTER_IP3,
			}
		end
	end

	config.vm.define "node-3" do |node3|
		node3.vm.network "private_network", ip: IP3
		node3.vm.network "private_network", ip: CLUSTER_IP3
		node3.vm.synced_folder ".", "/vagrant", nfs: true

		node3.vm.provision "puppet" do |puppet|
			puppet.module_path = "modules"
			puppet.manifests_path = "manifests"
			puppet.manifest_file = "node3.pp"
			puppet.hiera_config_path = "hiera_node3.yaml"
			puppet.facter = {
				"cluster_ip" => CLUSTER_IP3,
				"ip1" => CLUSTER_IP1,
				"ip2" => CLUSTER_IP2,
				"ip3" => CLUSTER_IP3,
			}
		end
	end

	#config.vm.box = "ubuntu14.04-server-amd64"
	#config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
	config.vm.box = "fedora-20"
	config.vm.box_url = "https://dl.dropboxusercontent.com/u/15733306/vagrant/fedora-20-netinst-2014_01_05-minimal-puppet-guestadditions.box"

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--cpus", "1"]
		vb.customize ["modifyvm", :id, "--memory", "1024"]
	end
end
