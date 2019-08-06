module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:yandex] = OmniAuth::AuthHash.new({
        'provider' => 'yandex',
        'uid' => '123545',
        'info' => {
            'email' => 'user@test.com'
        },
        'credentials' => {
            'token' => 'mock_token',
            'secret' => 'mock_secret'
        }
    })
  end
end
