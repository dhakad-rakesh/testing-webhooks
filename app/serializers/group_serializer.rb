class GroupSerializer < BaseSerializer
  attributes :id, :name
  has_many :users
end
