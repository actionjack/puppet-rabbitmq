# = Class: rabbitmq::service
#
#   class description goes here.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rabbitmq::service {

  $rabbitmq         = $rabbitmq::rabbitmq
  $rabbitmquser     = $rabbitmq::rabbitmquser
  $rabbitmqpassword = $rabbitmq::rabbitmqpassword
  $rabbitmqvhost    = $rabbitmq::rabbitmqvhost

  service {'rabbitmq-server':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class['rabbitmq::packages']
  }

  exec{"add_${rabbitmq}_vhost":
    command => "rabbitmqctl add_vhost ${rabbitmqvhost}",
    unless  => "rabbitmqctl list_vhosts | egrep -q ^${rabbitmqvhost}",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Service['rabbitmq-server']
  }

  exec{"add_${rabbitmq}_user":
    command => "rabbitmqctl add_user ${rabbitmquser} ${rabbitmqpassword}",
    unless  => "rabbitmqctl list_users | egrep -q ^${rabbitmquser}",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Service['rabbitmq-server']
  }

  exec{"set_${rabbitmq}_permissions":
    command => "rabbitmqctl set_permissions -p ${rabbitmqvhost} ${rabbitmquser} \".*\" \".*\" \".*\"",
    unless  => "rabbitmqctl list_permissions -p ${rabbitmqvhost} | egrep -q \"^${rabbitmquser}.*\\*.*\\.\\*.*\\.\\*$\"",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => [Service['rabbitmq-server'], Exec["add_${rabbitmq}_user"], Exec["add_${rabbitmq}_vhost"]]
  }

}
