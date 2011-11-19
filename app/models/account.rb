# -*- coding: utf-8 -*-
class Account < ActiveRecord::Base
  has_many :wordrobes, :dependent => :destroy
  has_many :words, :through => :wordrobes

  validates :uid, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  attr_accessible :uid, :first_name, :last_name, :nickname, :display_memorized, :show_profile, :comment
  attr_protected :created_at, :updated_at

  def save_with_omniauth!(auth)
    self.uid = auth["uid"]
    self.first_name = auth["user_info"]["first_name"]
    self.last_name = auth["user_info"]["last_name"]
    self.nickname = auth["user_info"]["nickname"]
    save!
  end
end
