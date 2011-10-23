Rails.application.config.middleware.use OmniAuth::Builder do  
  # TODO : change callback url
  provider :facebook, "156782621083661", "b3fbca92e9950d732c6e1220d62c8700"
end  
