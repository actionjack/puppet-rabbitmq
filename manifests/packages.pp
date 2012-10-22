# = Class: rabbitmq::packages
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
class rabbitmq::packages {
  $packagelist = ['rabbitmq-server']
  package { $packagelist: ensure => installed }
}
