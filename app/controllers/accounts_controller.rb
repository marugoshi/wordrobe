# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :login_required

  def dashboard
    @wordrobe = current_account.wordrobes
  end
end
