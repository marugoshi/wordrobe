# -*- coding: utf-8 -*-
Reaper::Application.routes.draw do
  match "/auth/twitter/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get

  match "/dashboard" => "accounts#dashboard", :as => "dashboard", :via => :get
end
