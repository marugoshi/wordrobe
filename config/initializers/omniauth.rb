Rails.application.config.middleware.use OmniAuth::Builder do  
  # TODO : change callback url
  provider :facebook, "156782621083661", "b3fbca92e9950d732c6e1220d62c8700"
end  

if Rails.env == "development"
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = {
    "provider" => "facebook",
    "uid" => "123456",
    "user_info" => {
      "first_name" => "Makoto",
      "last_name" => "Tokuyama",
      "nickname" => "marugoshi",
      "image_url" => "http://www.facebook.com/123456/picture?type=square",
      "urls" => {
        "Facebook" => "http://www.facebook.com/marugoshi"
      }
    },
  }
end
