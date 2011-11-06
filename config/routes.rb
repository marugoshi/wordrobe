# -*- coding: utf-8 -*-
Reaper::Application.routes.draw do
  match "/auth/facebook/callback" => "sessions#create", :as => "auth_provider_callback", :via => :get
  match "/log_out" => "sessions#destroy", :as => "log_out", :via => :delete

  match "/" => "static#welcome", :as => "welcome", :via => :get
  match "/dashboard" => "accounts#dashboard", :as => "dashboard", :via => :get

  match "/words/autocomplete_word_name" => "words#autocomplete_word_name", :as => "autocomplete_word_name_words", :via => :get
  match "/words/oops" => "words#oops_no_word", :as => "oops_no_word", :via => :get

  namespace :accounts do
    resources :wordrobes, :only => [:create] do
      match "page_index", :action => "index_with_ajax", :as => "page_index", :via => :get, :on => :collection
      match "toggle_memorize", :action => "toggle_memorize_with_ajax", :as => "toggle_memorize", :via => :put
      match "destroy", :action => "destroy_with_ajax", :as => "destroy", :via => :delete
    end
  end
end
