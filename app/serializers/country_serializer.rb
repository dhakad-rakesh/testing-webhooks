class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :uid, :number_of_matches, :alpha2

  has_many :tournaments

  def number_of_matches
    @instance_options.fetch(:number_of_matches, nil)
  end

  def tournaments
    object.tournaments
      .filter_by_sport(@instance_options.fetch(:sport_id))
      .active_tournaments_with_number_of_matches
      .sort_by_rank
  end

  def alpha2
    Mobility.with_locale(:en) do 	
      Rails.cache.fetch("#{object.name}_alpha2") do
        ISO3166::Country.find_country_by_name(object.name)&.alpha2
      end
    end
  end
end
