class PlayTypeSerializer < BaseSerializer
  attributes :id, :name
  has_many :bet_types

  def name
    object.name.titleize
  end
end
