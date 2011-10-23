# -*- coding: utf-8 -*-
class Word < ActiveRecord::Base
  has_many :account_words
  has_many :accounts, :through => :account_words

  validates :name, :presence => true

  attr_accessible :name
  attr_protected :created_at, :updated_at
end
