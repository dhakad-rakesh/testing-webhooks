class TeamPlayerSerializer < BaseSerializer
  attributes :id, :name, :jersey_number, :uid
  has_many :match_outcomes do
    object.match_outcomes.last
  end

  def name
    object.jersey_number.to_s + ' ' + object.name.to_s.split(',').first
  end
end
