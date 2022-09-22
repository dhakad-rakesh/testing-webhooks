class Api::PagesController < Api::BaseController
  skip_before_action :user_authorize!

  def privacy_policy
    render html: t('privacy_policy_html').html_safe
  end

  def rules
    render html: t('rules').html_safe
  end

  def terms
    render html: t('tnc_html').html_safe
  end

  def responsible_gambling
    render html: t('responsible_gambling_html').html_safe
  end

  def faqs
    render html: t('faqs_html').html_safe
  end

  def sports_betting
    render html: t('sports_betting_html').html_safe
  end
end
