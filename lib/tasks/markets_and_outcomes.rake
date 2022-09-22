namespace :market_and_outcomes do
  desc "Create markets and outcomes from GoalServe::Feed::MarketList"
  task create: :environment do
    Soccer::Feed::GS::MarketListJob.perform_later
  end
end
