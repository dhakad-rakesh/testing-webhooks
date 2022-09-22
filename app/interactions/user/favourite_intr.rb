class User::FavouriteIntr < ApplicationInteraction
  object :user
  hash :favourite_params, strip: false, default: {}
  TOURNAMENTS = %w[favourite_league favourite_tournament favourite_cup].freeze

  def execute
    add_favourite_tournaments
  end

  private

  def add_favourite_tournaments
    favourite_params.each do |key, value|
      type = TOURNAMENTS.include?(key) ? 'Tournament' : 'Team'
      next if value.blank?
      object = type.constantize.find_by(name: value)
      add_favourite(object, key)
    end
  end

  def add_favourite(object, key)
    if object.blank?
      errors.add(:base, I18n.t('favourite.not_found_key', key: key.split('_')[1]))
    elsif not_favourite?(object)
      user.favourites.create(favouriteable_type: object.class, favouriteable_id: object.id)
    end
  end

  def not_favourite?(object)
    user.favourites.none? { |f| f.favouriteable_id == object.id && f.favouriteable_type == object.class.to_s }
  end
end
