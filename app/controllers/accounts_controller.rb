# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :login_required

  def dashboard
    @wordrobe = current_account.account_words.for_dashboard
  end
end
