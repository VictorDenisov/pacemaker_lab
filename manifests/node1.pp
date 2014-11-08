stage { 'first':
	before => Stage['main'],
}

#class { 'apt':
#	stage => first,
#}

package { 'git':
	ensure => present,
}

include profiles::ha_node
