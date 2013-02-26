# = Class: rabbitmq
#
# This class installs and configures a RabbitMQ-Server.
#
# == Parameters:
#
# Check params.pp to configure
#
# == Actions:
#   Installs and configures a rabbitmq-server.
#
# == Requires:
#   - Package["rabbitmq-server"] in your local repo
#
# == Sample Usage:
#
# site.pp:
#    import "rabbitmq" (optional since it's in autoload format)
#
# nodes.pp:
#    class rabbitmq-server{
#        include rabbitmq
#      # If you want the webconsole:
#      # include rabbitmq::webconsole
#    }
#
class rabbitmq (
  $rabbitmq         = undef,
  $rabbitmquser     = undef,
  $rabbitmqpassword = undef,
  $rabbitmqvhost    = undef,
  $enable_console   = true
) {

  include rabbitmq::packages
  include rabbitmq::service

  if $rabbitmq::enable_console == true or
     $rabbitmq::enable_console == 'enable' 
     {
       include rabbitmq::console
     } 
}
