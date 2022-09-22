# module BR
#   module AMQP
#     class ListnerJob < ApplicationJob
#       queue_as :amqp_client

#       def perform(replay = false)
#         @@objects ||= [] # rubocop:disable Style/ClassVars
#         listner = (replay ? ::AMQP::ReplayListner.run! : ::AMQP::Listner.run!)
#         @@objects << listner
#         size = @@objects.size
#         return if size == 1
#         @@objects.each_with_index do |value, i|
#           i == (size - 1) ? (@@objects = [listner]) : value.close # rubocop:disable Style/ClassVars
#         end
#       end
#     end
#   end
# end
