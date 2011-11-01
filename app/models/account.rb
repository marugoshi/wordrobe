# -*- coding: utf-8 -*-
class Account < ActiveRecord::Base
  has_many :wordrobes, :dependent => :destroy
  has_many :words, :through => :wordrobes

  validates :uid, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  attr_accessible :uid, :first_name, :last_name, :nickname, :image_url, :facebook_url
  attr_protected :created_at, :updated_at

  def save_with_omniauth!(auth)
    self.uid = auth["uid"]
    self.first_name = auth["user_info"]["first_name"]
    self.last_name = auth["user_info"]["last_name"]
    self.nickname = auth["user_info"]["nickname"]
    self.image_url = auth["user_info"]["image_url"]
    if auth["user_info"].has_key?("urls") && auth["user_info"]["urls"].has_key?("Facebook")
      self.facebook_url = auth["user_info"]["urls"]["Facebook"] 
    end
    save!
  end
end
