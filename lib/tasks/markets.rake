namespace :markets do
  desc "Create markets from LSports"
  task create: :environment do
    Lsports::Markets.create
  end
end
