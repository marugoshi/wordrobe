# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_account

  private
  def login_required
    unless current_account
      session[:attempted_path] = ::Rack::Request.new(env).fullpath
      redirect_to sign_in_path
    end
  end

  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end
end
