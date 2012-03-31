# -*- coding: utf-8 -*-
class Word < ActiveRecord::Base
  has_many :word_containers
  has_many :accounts, :through => :word_containers

  validates :name, :presence => true

  attr_accessible :name
  attr_protected :created_at, :updated_at
end
