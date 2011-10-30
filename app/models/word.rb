# -*- coding: utf-8 -*-
class Word < ActiveRecord::Base
  has_many :wordrobes
  has_many :accounts, :through => :wordrobes

  validates :name, :presence => true

  attr_accessible :name
  attr_protected :created_at, :updated_at
end
