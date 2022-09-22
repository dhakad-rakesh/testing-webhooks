class CasinoItemSerializer < BaseSerializer
  attributes :id, :uuid, :name, :image, :item_type, :provider, :technology, :has_lobby, :is_mobile, :has_freespins, :active, :created_at, :updated_at
end
