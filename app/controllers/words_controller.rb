# -*- coding: utf-8 -*-
class WordsController < ApplicationController
  before_filter :login_required
  autocomplete :word, :name

  def oops_no_word
  end
end
