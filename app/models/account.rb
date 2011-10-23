# -*- coding: utf-8 -*-
class Account < ActiveRecord::Base
  has_many :account_words, :dependent => :destroy
  has_many :words, :through => :account_words

  validates :uid, :presence => true
  validates :name, :presence => true

  attr_accessible :uid, :name, :nickname
  attr_protected :created_at, :updated_at

  def save_with_omniauth!(auth)
    self.uid = auth["uid"]
    self.name = auth["user_info"]["name"]
    self.nickname = auth["user_info"]["nickname"]
    save!
  end
end
