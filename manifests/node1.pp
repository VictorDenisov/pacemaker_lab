stage { 'first':
	before => Stage['main'],
}

#class { 'apt':
#	stage => first,
#}

package { 'git':
	ensure => present,
}

exec { '/usr/bin/hostname node-1': }

file { '/etc/hostname':
	ensure  => file,
	content => "node-1",
	owner   => 'root',
	group   => 'root',
}

include profiles::ha_node
