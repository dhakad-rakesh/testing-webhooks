class UserSerializer < BaseSerializer
  attributes :id, :first_name, :last_name, :email, :username, :user_type, :gender,
    :favourite_team, :favourite_league, :favourites, :traditional_bet,
    :preferences, :interests, :fan_club, :related_topics,
    :selfie_picture_url, :govt_id_picture_url, :id_picture_url, :state, :phone,
    :kyc_status, :kyc_status_notes, :country_code, :date_of_birth, :unverified_phone, :unconfirmed_email,
    :user_number, :profile_pic, :referral_code, :locale, :subscribed_to_notifications,
    :bank_name, :account_number, :account_holder_name

  attribute :wallet
  attribute :address
  attribute :reality_check_limit
  attribute :common_settings

  def common_settings
    object.user_settings
  end

  def wallet
    current_wallet = object.current_wallet
    WalletSerializer.new(current_wallet) if current_wallet
  end

  def preferences
    %I[language dialect country occupation organization odds_format].map do |preference|
      { preference => object.send(preference) }
    end.inject(:merge)
  end

  def favourites
    user = (current_user || object)
    {
      sports: user.favourite_sports,
      teams: user.favourite_teams,
      tournaments: user.favourite_tournaments
    }
  end

  def fetch_fav_leagues(tournaments)
    Array.wrap(tournaments.league.first).compact
  end

  def fetch_fav_tournament(tournaments)
    Array.wrap(tournaments.tournament.first).compact
  end

  def fetch_fav_cup(tournaments)
    Array.wrap(tournaments.cup.first).compact
  end

  def interests
    %I[interest_online_talk interest_online_video_talk interest_online_video_competition].map do |interest|
      { interest => object.send(interest) }
    end.inject(:merge)
  end

  # TODO : Need to refactor
  def fan_club
    chapter_info = {}
    chapter_location =
      [
        %I[street city country zip].map do |chapter|
          chapter_info["chapter_#{chapter}"] = object.send("chapter_#{chapter}")
        end
      ].reject(&:empty?).join(' ')
    chapter_info = chapter_info.symbolize_keys
    {
      chapter_name: object.send(:chapter_name).to_s,
      chapter_street: chapter_info[:chapter_street].to_s,
      chapter_city: chapter_info[:chapter_city].to_s,
      chapter_country: chapter_info[:chapter_country].to_s,
      chapter_zip: chapter_info[:chapter_zip].to_s,
      chapter_location: chapter_location
    }
  end

  def related_topics
    current_user&.topics
  end

  def with_wallet?
    instance_options[:with_wallet]
  end

  def traditional_bet
    (current_user || object).points_info('traditional')
  end

  def profile_pic
    # user = (current_user || object)
    # if user.image&.attachment&.present?
    #   Rails.application.routes.url_helpers.url_for(user.image) if user.image_blob.present?
    # else
    #   Rails.application.routes.url_helpers.root_url + ActionController::Base.helpers.image_url('unnamed.png')
    # end
  end

  def selfie_picture_url
    Rails.application.routes.url_helpers.url_for(object&.selfie_picture) if object.selfie_picture_blob.present?
  end

  def govt_id_picture_url
    Rails.application.routes.url_helpers.url_for(object&.govt_id_picture) if object.govt_id_picture_blob.present?
  end

  def id_picture_url
    Rails.application.routes.url_helpers.url_for(object&.id_picture) if object.id_picture_blob.present?
  end

  def reality_check_limit
    object.reality_check_timer&.strftime('%M minute')
  end

  def phone
    object.phone[object.country_code.length..-1] rescue object.phone
  end
  
end
