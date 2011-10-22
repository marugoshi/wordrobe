# -*- coding: utf-8 -*-
class Word < ActiveRecord::Base
  has_many :account_words
  has_many :accounts :through => :account_words

  validates :word, :presence => true

  attr_protected :word, :created_at, :updated_at
end
