module DynamicLinksHelper
  def dynamic_url(link)
    "#{base_url}/?link=#{link}&#{packages}"
  end

  def base_url
    ENV.fetch('DYNAMIC_URL_BASE', "https://appkoorabet.page.link")
  end

  def packages
    "apn=com.koorabet&amv=1&ibi=com.koorabet.org"
  end
end

