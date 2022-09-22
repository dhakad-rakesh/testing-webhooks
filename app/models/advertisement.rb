class Advertisement < ApplicationRecord
  store :settings, coder: Hash, accessors: %I[position]
  
  has_one_attached :web_ad_image
  has_one_attached :app_ad_image

  validate :ad_image
  validates_numericality_of :per_click_cost, :greater_than_or_equal_to => 0.0

  validate :image_validation
  # validate :ad_image_validation
  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :ads_position, ->(pos) { where(settings: { position: pos }, enabled: true) }
  scope :enabled, -> { where(enabled: true) }

  POSITIONS = ['top', 'left', 'right'].freeze

  def ad_image
    return errors[:base] << 'Please upload the web ad image' unless web_ad_image.attached?
    errors[:base] << 'Please upload the mobile ad image' unless app_ad_image.attached?
  end


  def image_validation
    return unless web_ad_image.attached? || app_ad_image.attached?
    %w[web_ad_image app_ad_image].each do |file|
      file = send(file)
      # unless ( file.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/)
      unless file.content_type.starts_with?('image/')  
        web_ad_image.purge
        app_ad_image.purge
        return errors[:base] << 'Please upload image in jpg/jpeg/png format' 
      end
    end
  end

  def ad_image_validation
    return unless web_ad_image.attached? || app_ad_image.attached?
    
    web_blob_object = web_ad_image.blob
    app_blob_object = app_ad_image.blob

    validation_msg = 
      unless web_blob_object.content_type.starts_with?('image/') || app_blob_object.content_type.starts_with?('image/')
        I18n.t('wrong_img_format')
      else
        web_img = calculate_image_size(web_ad_image)
        app_img = calculate_image_size(app_ad_image)

        case position
        when 'top'
          I18n.t('web_wrong_dimentions', w: 250, h: 300) if web_img[:width] < 563 || web_img[:height] < 221
          I18n.t('app_wrong_dimentions', w: 250, h: 300) if app_img[:width] < 375 || app_img[:height] < 100
        when 'right'
          I18n.t('web_wrong_dimentions', w: 250, h: 300) if web_img[:width] < 250 || web_img[:height] < 300
          I18n.t('app_wrong_dimentions', w: 375, h: 100) if app_img[:width] < 375 || app_img[:height] < 100
        else
          I18n.t('web_wrong_dimentions', w: 250, h: 300) if web_img[:width] < 168 || web_img[:height] < 85
          I18n.t('app_wrong_dimentions', w: 250, h: 300) if app_img[:width] < 375 || app_img[:height] < 100
        end
      end
    if validation_msg
      web_ad_image.purge
      app_ad_image.purge
      errors[:base] << validation_msg
    end
  end

  def calculate_image_size(ad_image)
    image_url = Rails.application.routes.url_helpers.url_for(ad_image)
    img = MiniMagick::Image.open(image_url)
  end
end
