class Casino::CreateItemJob < ApplicationJob
  queue_as :game_sessions

  def perform(page)
    response = client.without_lobby(params: requested_params(page))
    json_response = JSON.parse(response)

    return if json_response['items'].blank?

    json_response['items'].each do |item|
      create_or_update_items(item)
    end
  end

  private

  def create_or_update_items(item)
    item['item_type'] = item['type']
    item.except!('type')
    item.except!('freespin_valid_until_full_day')

    return unless Constants::CASINO_AVAIALBLE_PROVIDERS.include?(item['provider'])

    if Constants::CASINO_PROVIDERS_WITHOUT_LOBBIES.include?(item['provider'])
      # Remove has_lobby=1 params from item for selected providers
      item.except!('has_lobby')
    end

    available_casino_items_uuid(item['uuid'])

    if ci = CasinoItem.find_by(uuid: item['uuid'])
      ci.update(item.merge(active: true))
    else
      CasinoItem.create(item)
    end
  end

  def requested_params(page)
    { 'page' => page }
  end

  def client
    @client ||= Casino::Client.new
  end

  def available_casino_items_uuid(uuid)
    data = Rails.cache.fetch('available_casino_items_uuid')
    merged_data = begin
                    data.concat(", #{uuid}")
                  rescue StandardError
                    uuid
                  end
    Rails.cache.write('available_casino_items_uuid', merged_data)
  end
end
