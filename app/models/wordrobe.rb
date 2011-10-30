# -*- coding: utf-8 -*-
class Wordrobe < ActiveRecord::Base
  belongs_to :account
  belongs_to :word

  validates :account_id, :presence => true
  validates :word_id, :presence => true
  validates :register_count, :presence => true

  attr_accessible :account_id, :word_id, :register_count
  attr_protected :created_at, :updated_at

  scope :for_dashboard, limit(10)
  scope :for_list, limit(20)
  scope :count_asc, order("register_count ASC")
  scope :count_desc, order("register_count DESC")
  scope :created_asc, order("created_at ASC")
  scope :created_desc, order("created_at DESC")

  default_scope self.count_desc
end
