Reaper::Application.routes.draw do
  match "/auth/twitter/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
end
