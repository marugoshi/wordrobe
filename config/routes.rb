# -*- coding: utf-8 -*-
Reaper::Application.routes.draw do
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/log_out" => "sessions#destroy", :as => "log_out", :via => :delete

  match "/" => "static#welcome", :as => "welcome", :via => :get
  match "/dashboard" => "accounts#dashboard", :as => "dashboard", :via => :get

  match "/words/autocomplete_word_name" => "words#autocomplete_word_name", :as => "autocomplete_word_name_words", :via => :get

  namespace :accounts do
    resources :wordrobes, :except => [:index, :show, :new, :create, :edit, :update, :destroy] do
      match "create", :action => "create_with_ajax", :as => "create", :via => :post, :on => :collection
      match "wordrobes", :action => "wordrobes_with_ajax", :as => "wordrobes", :via => :get, :on => :collection
      match "rating", :action => "rating_with_ajax", :as => "rating", :via => :post, :on => :member
      # match "toggle_memorize", :action => "toggle_memorize_with_ajax", :as => "toggle_memorize", :via => :put
      # match "destroy", :action => "destroy_with_ajax", :as => "destroy", :via => :delete
    end
  end
end
