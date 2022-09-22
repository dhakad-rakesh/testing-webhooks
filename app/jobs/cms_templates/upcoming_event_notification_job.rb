# Every hour

module CmsTemplates
  class UpcomingEventNotificationJob < ApplicationJob
    queue_as :low

    def perform
      @contents = CmsTemplate.upcoming_event_notification #.order(updated_at: :desc).limit(1).first
      return if @contents.blank?

      Match.where(schedule_at: Time.zone.now..Time.zone.now + 1.hour).each do |match|
        user_ids = Favourite.where(favouriteable_type: 'Tournament', favouriteable_id: match.tournament_id).pluck(:user_id)
        tournament_name = match.tournament.name
        User.where(id: user_ids, upcoming_event_notification: true).find_in_batches do |group|
          group.each do |person|
            @contents.each do |content|
              CmsNotificationMailer.notification_details(
                person.email, "#{content.subject} for #{tournament_name} || #{match.title} ", content.content
              ).deliver_later
            end
          end
        end
      end
    end
  end
end
