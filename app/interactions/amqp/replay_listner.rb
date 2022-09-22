# require 'bunny'
# module AMQP
#   # Will make connection to the amqp client and create feed job which will
#   # process data accordingly
#   class ReplayListner < AMQP::Listner
#     object :session, default: nil, class: Bunny::Session
#     set_callback :validate, :after, -> { set_connection }

#     private

#     def set_connection
#       STDOUT.sync = true
#       @conn = Bunny.new(
#         host: 'replaymq.betradar.com',
#         vhost: '/unifiedfeed/21951',
#         port: 5671,
#         user: api_key,
#         password: api_key,
#         ssl: true,
#         verify_peer: false,
#         verify_peer_name: false,
#         allow_self_signed: true
#       )
#     end
#   end
# end
