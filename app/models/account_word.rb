# -*- coding: utf-8 -*-
class AccountWord < ActiveRecord::Base
  belongs_to :account
  belongs_to :word

  validates :account_id, :presence => true
  validates :word_id, :presence => true
  validates :register_count, :presence => true

  attr_accessible :account_id, :word_id, :register_count
  attr_protected :created_at, :updated_at

  scope :by, lambda { |account_id| where("account_id = ?", account_id) }
  scope :for_dashboard, lambda { limit(10) }
end
