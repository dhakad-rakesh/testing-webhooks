class OutcomeSerializer < BaseSerializer
  attributes :id
  has_one :match_outcomes

  attribute(:name) { replace_name_tag(object.name) }

  def match_outcomes
    object.match_outcomes.where(match_id: match.id, status: '1').last
  end
end
