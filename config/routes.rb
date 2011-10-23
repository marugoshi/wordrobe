# -*- coding: utf-8 -*-
Reaper::Application.routes.draw do
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/log_out" => "sessions#destroy", :as => "log_out", :via => :delete

  match "/" => "static#welcome", :as => "welcome", :via => :get
  match "/dashboard" => "accounts#dashboard", :as => "dashboard", :via => :get
end
