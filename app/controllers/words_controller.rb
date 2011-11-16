# -*- coding: utf-8 -*-
class WordsController < ApplicationController
  before_filter :login_required
  autocomplete :word, :name
end
