# -*- coding: utf-8 -*-
class Wordrobe < ActiveRecord::Base
  belongs_to :account
  belongs_to :word

  validates :account_id, :presence => true
  validates :word_id, :presence => true
  validates :register_count, :presence => true

  attr_accessible :account_id, :word_id, :register_count
  attr_protected :created_at, :updated_at

  paginates_per 1

  scope :alphabet_asc, order("words.name ASC")
  scope :alphabet_desc, order("words.name DESC")
  scope :count_asc, order("register_count ASC")
  scope :count_desc, order("register_count DESC")
  scope :created_asc, order("created_at ASC")
  scope :created_desc, order("created_at DESC")
  scope :updated_asc, order("updated_at ASC")
  scope :updated_desc, order("updated_at DESC")

  # scope :for_list, joins(:word).alphabet_asc.limit(20)
  scope :for_dashboard, lambda { |page| created_desc.page(page) }

  scope :memorized, where("rating IS NOT NULL")
  scope :not_memorized, where("rating IS NULL")

  def memorized?
    !!rating
  end
end
