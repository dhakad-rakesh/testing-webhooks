class QTechCasinoGameSerializer < BaseSerializer
  attributes :id, :uid, :name, :provider, :category, :supports_demo,
             :client_types, :languages, :currencies, :supported_devices,
             :free_spin_trigger, :image, :uuid
  belongs_to :casino_menu

  def image
    "#{Figaro.env.qtech_s3_base_url || base_url}/#{object.uid}.jpg"
  end

  def uuid
    object.uid
  end

  def base_url
    'https://mellotoken-production-active-storage.s3.eu-west-2.amazonaws.com/casino-images'
  end
end
