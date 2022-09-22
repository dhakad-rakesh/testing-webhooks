class SeasonSerializer < BaseSerializer
  attributes :id, :name, :acronym, :start_time, :end_time
  belongs_to :sport
  belongs_to :tournament
end
