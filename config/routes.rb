# -*- coding: utf-8 -*-
Reaper::Application.routes.draw do
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/log_out" => "sessions#destroy_with_ajax", :as => "log_out", :via => :delete

  match "/" => "static#welcome", :as => "welcome", :via => :get
  match "/dashboard" => "accounts#dashboard", :as => "dashboard", :via => :get

  namespace :accounts do
    resources :wordrobes, :except => [:index, :show, :new, :create, :edit, :update, :destroy] do
      get :autocomplete_word_name, :on => :collection
      match "create", :action => "create_with_ajax", :as => "create", :via => :post, :on => :collection
      match "wordrobes", :action => "wordrobes_with_ajax", :as => "wordrobes", :via => :get, :on => :collection
      match "toggle_memorize", :action => "toggle_memorize_with_ajax", :as => "toggle_memorize", :via => :put, :on => :member
      match "toggle_translate", :action => "toggle_translate_with_ajax", :as => "toggle_translate", :via => :put, :on => :member
    end
  end
end
