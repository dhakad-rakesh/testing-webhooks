class TournamentSerializer < BaseSerializer
  attributes :id, :title, :uid, :number_of_matches, :rank #, :tournament_type, :data
  belongs_to :sport
  belongs_to :country
  has_many :matches, if: '!!instance_options.fetch(:match, false)'
  with_options if: 'current_user.present?' do
    attribute(:is_favourite) { @favourite = current_user.favourite_tournaments.value?(object.id) }
    attribute(:favourite_id, if: '@favourite') { current_user.favourite_tournaments.key(object.id) }
  end

  def title
    object.name
  end

  def data
    return object.matches.active_with_live_matches if instance_options[:live_casino] == "live"
    object.matches.active_matches
  end
end
