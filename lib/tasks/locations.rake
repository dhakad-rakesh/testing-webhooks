namespace :locations do
  desc "Create locations from LSports"
  task create: :environment do
    Lsports::Locations.create
  end
end
