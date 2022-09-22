class SoccerMatchScoreSerializer < BaseSerializer
  attributes :id

  attributes(:periods) do
    object.periods
  end

  attributes(:match_statistics) do
    object.match_statistics
  end
end
