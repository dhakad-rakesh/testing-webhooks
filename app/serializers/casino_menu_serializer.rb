class CasinoMenuSerializer < BaseSerializer
  attributes :id, :name, :icon_url, :menu_type, :menu_order, :enabled
  attribute :featured_items, if: 'instance_options.fetch(:featured_items, false)'

  def featured_items
    object.casino_items&.active_items.first(6)
  end

  def icon_url
    "#{ENV['DOMAIN_URL']}#{ActionController::Base.helpers.asset_path("casino/default.png")}"
  end
end
