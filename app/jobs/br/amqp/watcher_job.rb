# module BR
#   module AMQP
#     class WatcherJob < ApplicationJob
#       queue_as :amqp_watcher
#       after_perform :enqueue_watcher

#       def perform
#         return if with_in_minutes?(watcher_last_check, 1)
#         return if listner_last_check.present? && with_in_minutes?(listner_last_check, 3)
#         clean_queue('amqp_client')
#         BR::AMQP::ListnerJob.perform_later
#         Rails.cache.write(:last_listner_data, Time.now.utc)
#         clean_queue('amqp_watcher')
#       end

#       def enqueue_watcher
#         notify_developers unless watcher_last_check.between?(5.minutes.ago.utc, Time.zone.now.utc)
#         BR::AMQP::WatcherJob.set(wait_until: 60.seconds).perform_later
#       end

#       private

#       def listner_last_check
#         @listner_last_check = Rails.cache.read(:last_listner_data)&.utc
#         return @listner_last_check if @listner_last_check.present?
#         @listner_last_check = Rails.cache.write(:last_listner_data, Time.zone.now - 10.minutes)
#       end

#       def watcher_last_check
#         @watcher_last_check = Rails.cache.read(:last_amqp_data_at)&.utc
#         return @watcher_last_check if @watcher_last_check.present?
#         @watcher_last_check = Rails.cache.write(:last_amqp_data_at, Time.zone.now - 10.minutes)
#       end

#       def clean_queue(queue)
#         Sidekiq::Queue.all.select { |a| a.name == queue }.first&.clear
#       end

#       def with_in_minutes?(time, range)
#         time.between?(range.minute.ago.utc, Time.zone.now.utc)
#       end

#       def notify_developers
#         AmqpClientErrorMailer.amqp_listner_down(
#           Figaro.env.developers_mail, Time.zone.now.to_s
#         ).deliver_later
#       end
#     end
#   end
# end
