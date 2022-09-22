module AdvertisementsHelper
  def ad_images(position)
    Advertisement.ads_position(position)
  end
end