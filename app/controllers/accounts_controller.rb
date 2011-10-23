# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :login_required

  def dashboard
    @words_belonged = AccountWord.by(current_account.id).limit(10)
  end
end
