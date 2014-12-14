class Decoder
  #include ActiveModel::Validations
  #include ActiveModel::Conversion
  #extend ActiveModel::Naming
  include ActiveModel::Model

  attr_accessor(
      :cookie,
      :secret_key
  )

  def decode_session
    require 'cgi'
    require 'active_support'

    decrypt_session_cookie_simple(cookie, secret_key)
  end

  def decrypt_session_cookie_simple(my_cookie, my_key)
    my_cookie = CGI::unescape(my_cookie)

    # Default values for Rails 4 apps
    key_iter_num = 1000
    salt         = "encrypted cookie"
    signed_salt  = "signed encrypted cookie"

    key_generator = ActiveSupport::KeyGenerator.new(my_key, iterations: key_iter_num)
    secret = key_generator.generate_key(salt)
    sign_secret = key_generator.generate_key(signed_salt)

    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    encryptor.decrypt_and_verify(my_cookie)
  end
end