class Image < ApplicationRecord
  has_one_attached :image
  validate :validate_image_size, on: :create

  def url
    Rails.application.routes.url_helpers.url_for(self.image)
  end

  def validate_image_size
    return unless image.attached?

    blob_object = image.blob

    validation_msg = 
      unless blob_object.content_type.starts_with?('image/')
        I18n.t('wrong_img_format')
      else
        img_size = calculate_image_size
        I18n.t('big_image') if img_size >= 1024000
      end
    if validation_msg
      image.purge
      errors[:base] << validation_msg
    end
  end

  private

  def calculate_image_size
    # image_url = Rails.application.routes.url_helpers.url_for(image)

    # img = MiniMagick::Image.open(image_url)
    image.blob.byte_size
  end
end
