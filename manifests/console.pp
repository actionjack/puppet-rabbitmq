# = Class: rabbitmq::console
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
class rabbitmq::console {
  Exec{
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    notify  => Service['rabbitmq-server'],
    require => Class['rabbitmq::packages']
  }
  exec{"enable_rabbitmq_mgmt":
    command => 'rabbitmq-plugins enable rabbitmq_management',
    unless  => "rabbitmq-plugins list rabbitmq_management | egrep '[E].*rabbitmq_management.*$'",
  }
  exec{"enable_rabbitmq_mgmt_visualiser":
    command => 'rabbitmq-plugins enable rabbitmq_management_visualiser',
    unless  => "rabbitmq-plugins list rabbitmq_management_visualiser | egrep '[E].*rabbitmq_management_visualiser.*$'",
  }
}
