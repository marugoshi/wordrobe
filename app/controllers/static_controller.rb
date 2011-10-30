# -*- coding: utf-8 -*-
class StaticController < ApplicationController
  def welcome
    redirect_to dashboard_path if current_account
  end
end
