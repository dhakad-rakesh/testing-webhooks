class UpdatePopupsStatusJob < ApplicationJob
  queue_as :default

  def perform
    Popup.inactive.where('start_date <= ?', Time.zone.now).update_all(status: :published)
    Popup.published.where('end_date <= ?', Time.zone.now - 1.hour).update_all(status: :trash)
  end
end
