class MatchOutcomeSerializer < BaseSerializer
  attributes :id, :odds
  belongs_to :outcome
end
