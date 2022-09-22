class SportSerializer < BaseSerializer
  attributes :id, :name, :status, :uid, :rank, :created_at, :enabled,  :number_of_matches, :image_url
  # has_many :matches, if: '!!instance_options.fetch(:match, false)'
  with_options unless: 'current_user.nil?' do
    attribute(:favourite) { @favourite = current_user.favourite_sports.value?(object.id) }
    attribute(:favourite_id, if: '@favourite') { current_user.favourite_sports.key(object.id) }
  end

  # def name
  #   return 'Football' if object.soccer?
  #   object.name
  # end

  # def matches
  #   object.matches.active_matches.active_within_7_days.limit(2)
  # end

  def image_url
    "#{ENV['DOMAIN_URL']}#{ActionController::Base.helpers.asset_path("sports_icon/api/#{object.uid}")}"
  rescue
    "#{ENV['DOMAIN_URL']}#{ActionController::Base.helpers.asset_path("sports_icon/api/default.png")}"
  end
end
