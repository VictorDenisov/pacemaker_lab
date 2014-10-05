class profiles::ha_node {
	include corosync
	corosync::service { 'pacemaker':
		version => '0',
	}
}
