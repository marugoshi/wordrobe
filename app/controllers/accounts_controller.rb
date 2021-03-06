# -*- coding: utf-8 -*-
class AccountsController < ApplicationController
  before_filter :login_required

  def dashboard
    @wordrobe = current_account.word_containers.for_dashboard(params[:page])
    @total = current_account.word_containers.count
  end

  def destroy_with_ajax
    current_account.destroy
    session[:account_id] = nil
    render :nothing => true
  end
end
