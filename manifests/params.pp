# = Class: rabbitmq::params
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
class rabbitmq::params {
  if $rabbitmq == undef {
    $rabbitmq = hiera('amqp_queue_name')
  }
  if $rabbitmquser == undef {
    $rabbitmquser = hiera('amqp_username')
  }
  if $rabbitmqpassword == undef {
    $rabbitmqpassword = hiera('amqp_userpassword')
  }
  if $rabbitmqvhost == undef {
    $rabbitmqvhost = hiera('amqp_virtual_host')
  }
}
