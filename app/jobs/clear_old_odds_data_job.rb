class ClearOldOddsDataJob < ApplicationJob
  queue_as :low
  def perform
    matches = Match.where(status: :ended).where("schedule_at between ? and ?", (Time.now.beginning_of_day - 2.week), (Time.now.beginning_of_day - 1.week)).select(:id, :uid)
    matches.find_in_batches do |group|
      group.each do |match|
        OddStore.new(match.uid).remove_odds_data rescue nil # remove odds from redis store
        OddsStore::CloudFirestore.delete_with_path("#{Constants::ODDS_UPDATE_CHANNEL}/#{match.uid}") rescue nil
        OddsStore::CloudFirestore.delete_with_path("#{Constants::STATUS_UPDATE_CHANNEL}/#{match.uid}") rescue nil
      end
    end
  end
end