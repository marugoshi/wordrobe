# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :login_required

  def dashboard
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    @total = current_account.wordrobes.count
  end
end
