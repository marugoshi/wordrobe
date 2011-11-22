# -*- coding: utf-8 -*-
class Wordrobe < ActiveRecord::Base
  belongs_to :account
  belongs_to :word

  validates :account_id, :presence => true
  validates :word_id, :presence => true

  attr_accessible :account_id, :word_id, :translated_count, :memorize, :rating
  attr_protected :created_at, :updated_at

  paginates_per 1

  scope :alphabet_asc, order("words.name ASC")
  scope :alphabet_desc, order("words.name DESC")
  scope :rating_asc, order("rating_count ASC")
  scope :rating_desc, order("rating_count DESC")
  scope :created_asc, order("created_at ASC")
  scope :created_desc, order("created_at DESC")
  scope :updated_asc, order("updated_at ASC")
  scope :updated_desc, order("updated_at DESC")

  # scope :for_list, joins(:word).alphabet_asc.limit(20)
  scope :for_dashboard, lambda { |x|
    if x
      x = page.num_pages if x.to_i > page.num_pages
      x = 1 if x.to_i < 1
    end
    created_desc.page(x)
  }
end
