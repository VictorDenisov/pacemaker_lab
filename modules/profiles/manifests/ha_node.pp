class profiles::ha_node {
	#include corosync
	#corosync::service { 'pacemaker':
	#version => '0',
	#}
	package { 'pacemaker':
		ensure => present,
	}
	package { 'pcs':
		ensure => present,
	}
	host { 'node-1':
		ip => $::ip1,
	}
	host { 'node-2':
		ip => $::ip2,
	}
	host { 'node-3':
		ip => $::ip3,
	}
	file { '/home/vagrant/.ssh/id_rsa':
		ensure => file,
		source => 'puppet:///modules/profiles/id_rsa',
		owner  => 'vagrant',
		group  => 'vagrant',
	}
	file { '/home/vagrant/.ssh/id_rsa.pub':
		ensure => file,
		source => 'puppet:///modules/profiles/id_rsa.pub',
		owner  => 'vagrant',
		group  => 'vagrant',
	}
	ssh_authorized_key { 'vdenisov@victor-office':
		user => 'vagrant',
		type => 'ssh-rsa',
		key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVUB0omENJQ+vOwWNKLiEPwKK+NTdPV3l0J9jvyZ0sLemAYHp4DA46hbS4IaeYBE+DYTnsFX+ZhRYFzlKGVFHOPto99WfwsFrK81w8z6tdZENN8RwFZozkbfQRxMmVtMHGS6XMOOYAnDwlHOyh6O5uNa01pdKbAm9mjlWb5+ELgxLxmeuXDTz4UqzxLzfQ9jzIEMH7MTKemFoBSZhIqvpZJW4ykFWwSCFD3UMAs8J3zRmNZJnbn/G9pwg4U7HqwdYGP4MucVjqg3HliBRQlnhBkKnNQswnBNwf0BbM4Fd4BJ64qw868H7MvYWw//05FOP+t7IlgGKL6VsOycISXoDh',
	}

	sshkey { 'node-1':
		ensure       => present,
		host_aliases => $::ip1,
		key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVUB0omENJQ+vOwWNKLiEPwKK+NTdPV3l0J9jvyZ0sLemAYHp4DA46hbS4IaeYBE+DYTnsFX+ZhRYFzlKGVFHOPto99WfwsFrK81w8z6tdZENN8RwFZozkbfQRxMmVtMHGS6XMOOYAnDwlHOyh6O5uNa01pdKbAm9mjlWb5+ELgxLxmeuXDTz4UqzxLzfQ9jzIEMH7MTKemFoBSZhIqvpZJW4ykFWwSCFD3UMAs8J3zRmNZJnbn/G9pwg4U7HqwdYGP4MucVjqg3HliBRQlnhBkKnNQswnBNwf0BbM4Fd4BJ64qw868H7MvYWw//05FOP+t7IlgGKL6VsOycISXoDh',
		type         => 'ssh-rsa',
	}
	sshkey { 'node-2':
		ensure       => present,
		host_aliases => $::ip2,
		key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVUB0omENJQ+vOwWNKLiEPwKK+NTdPV3l0J9jvyZ0sLemAYHp4DA46hbS4IaeYBE+DYTnsFX+ZhRYFzlKGVFHOPto99WfwsFrK81w8z6tdZENN8RwFZozkbfQRxMmVtMHGS6XMOOYAnDwlHOyh6O5uNa01pdKbAm9mjlWb5+ELgxLxmeuXDTz4UqzxLzfQ9jzIEMH7MTKemFoBSZhIqvpZJW4ykFWwSCFD3UMAs8J3zRmNZJnbn/G9pwg4U7HqwdYGP4MucVjqg3HliBRQlnhBkKnNQswnBNwf0BbM4Fd4BJ64qw868H7MvYWw//05FOP+t7IlgGKL6VsOycISXoDh',
		type         => 'ssh-rsa',
	}
	sshkey { 'node-3':
		ensure       => present,
		host_aliases => $::ip3,
		key          => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVUB0omENJQ+vOwWNKLiEPwKK+NTdPV3l0J9jvyZ0sLemAYHp4DA46hbS4IaeYBE+DYTnsFX+ZhRYFzlKGVFHOPto99WfwsFrK81w8z6tdZENN8RwFZozkbfQRxMmVtMHGS6XMOOYAnDwlHOyh6O5uNa01pdKbAm9mjlWb5+ELgxLxmeuXDTz4UqzxLzfQ9jzIEMH7MTKemFoBSZhIqvpZJW4ykFWwSCFD3UMAs8J3zRmNZJnbn/G9pwg4U7HqwdYGP4MucVjqg3HliBRQlnhBkKnNQswnBNwf0BbM4Fd4BJ64qw868H7MvYWw//05FOP+t7IlgGKL6VsOycISXoDh',
		type         => 'ssh-rsa',
	}
	exec { '/usr/sbin/setenforce 0': }
	augeas { 'selinux':
		changes => [ "set /files/etc/selinux/config/SELINUX permissive",
		           ]
	}
	service { 'iptables':
		ensure => stopped,
		enable => false,
	}
	service { 'firewalld':
		ensure => stopped,
		enable => false,
	}
	service { 'pcsd':
		ensure  => running,
		enable  => true,
		require => [Package['pcs'], Package['pacemaker']],
	}
	user { 'hacluster':
		ensure   => present,
		password => '$1$FQenn7CV$2yfATqj3zEqKkBt8r3O07.',
	}
# This key is from file modules/profiles/id_rsa.pub update this if you change id_rsa.pub
}
