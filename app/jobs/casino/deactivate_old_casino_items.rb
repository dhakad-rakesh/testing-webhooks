class Casino::DeactivateOldCasinoItems < ApplicationJob
  queue_as :game_sessions

  def perform
    return if active_casino_items_uuid.blank?

    casino_items = CasinoItem.where.not(uuid: active_casino_items_uuid)

    # Deactivate other casino items
    casino_items.update_all(active: false)

    # Clear cache data
    Rails.cache.write('available_casino_items_uuid', nil)
  end

  private

  def active_casino_items_uuid
    data = Rails.cache.fetch('available_casino_items_uuid')
    data.split(', ')
  rescue StandardError
    []
  end
end
