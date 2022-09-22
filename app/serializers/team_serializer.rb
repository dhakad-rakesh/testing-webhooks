class TeamSerializer < BaseSerializer
  attributes :id, :name, :country_name, :acronym
  belongs_to :sport#, if: '!!instance_options.fetch(:sport, true)'
  attribute :qualifier, if: '!!instance_options.fetch(:qualifier, false)'
  has_many :team_players
  with_options unless: 'current_user.nil?' do
    attribute(:favourite) { @favourite = current_user.favourite_teams.value?(object.id) }
    attribute(:favourite_id, if: '@favourite') { current_user.favourite_teams.key(object.id) }
  end

  def qualifier
    return nil if instance_options[:event]&.team_info&.blank?
    instance_options[:event].team_info.dig(object.uid, :qualifier)
  end
end
