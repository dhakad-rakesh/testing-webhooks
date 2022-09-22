class AdvertisementSerializer < BaseSerializer
  attributes :id, :name, :position, :web_image_url, :app_image_url, :ad_url

  def web_image_url
    Rails.application.routes.url_helpers.url_for(object&.web_ad_image)
  end

  def app_image_url
    Rails.application.routes.url_helpers.url_for(object&.app_ad_image)
  end
  # def image_url
  #   if object.ad_image.attached? && object.ad_image_blob.present?
  #     Rails.application.routes.url_helpers.url_for(object&.ad_image)
  #   else
  #     asset_name = object.position.parameterize.underscore
  #     Rails.application.routes.url_helpers.root_url + ActionController::Base.helpers.image_url(asset_name)
  #   end
  # end

end
