class BetTypeSerializer < BaseSerializer
  attributes :id, :name
  has_many :play_types

  def name
    object.name.titleize
  end
end
