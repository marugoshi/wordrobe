# -*- coding: utf-8 -*-
class AccountWords < ActiveRecord::Base
  belongs_to :account
  belongs_to :word

  validates :account_id, :presence => true
  validates :word_id, :presence => true
  validates :register_count, :presence => true

  attr_protected :account_id, :word_id, :register_count, :created_at, :updated_at
end
