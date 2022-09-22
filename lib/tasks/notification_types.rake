namespace :notification_types do
  desc "Create notification types"
  task create: :environment do
    Constants::NOTIFICATION_KIND.each do |kind, name|
      notification_type = NotificationType.find_or_initialize_by(kind: kind)
      notification_type.update(name: name.humanize)
    end
  end
end
