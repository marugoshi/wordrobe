# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    account = Account.where(:uid => auth["uid"]).first
    account = current_account ? current_account : Account.new unless account
    account.save_with_omniauth!(auth)

    # TODO : should keep session at least 2 week
    session[:account_id] = account.id
    attempted_path = session[:attempted_path] || dashboard_path
    session[:attempted_path] = nil
    redirect_to attempted_path
  end

  def destroy
    session[:account_id] = nil
    redirect_to welcome_path
  end
end
