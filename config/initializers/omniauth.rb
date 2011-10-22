Rails.application.config.middleware.use OmniAuth::Builder do  
  # TODO : change callback url
  provider :twitter, "PuSw5zuU8y1C9ksr1P4Gw", "wz01NRqZlwSDNtqAjW8JbDbh8GsD0QXjuXC1sasZvbI"
  provider :facebook, "156782621083661", "b3fbca92e9950d732c6e1220d62c8700"
end  
