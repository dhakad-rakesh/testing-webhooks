class Casino::CreateItemsJob < ApplicationJob
  queue_as :game_sessions

  def perform
    response = client.without_lobby
    page_count = response.headers[:x_pagination_page_count].to_i

    (1..page_count).each do |page|
      Casino::CreateItemJob.perform_later(page)
    end

    # Execute job after 15 minutes
    Casino::DeactivateOldCasinoItems.set(wait: 15.minutes).perform_later
  end

  private

  def client
    @client ||= Casino::Client.new
  end
end
