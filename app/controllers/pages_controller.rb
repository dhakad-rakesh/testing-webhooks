class PagesController < BaseController
  layout 'koorabet_theme'
  skip_before_action :authenticate_user!

  def privacy_policy
  end

  def rules
  end

  def terms
  end

  def tnc
  end

  def privacy
  end

  def help
  end

  def responsible
  end
end
