module ApplicationHelper
  def provider_name(provider)
    return 'Яндекс' if provider == 'Yandex'
    'Google' if provider == 'GoogleOauth2'
  end
end
