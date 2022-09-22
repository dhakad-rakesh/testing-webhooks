module AdminDashboard
  class SportPresenter
    def self.popular_sport
      data = []
      Sport.where(enabled: true).each do |sport|
        data << { name: sport.name, count: sport.favourites.count }
      end
      data
    end
  end
end
