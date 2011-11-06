# -*- coding: utf-8 -*-
module Accounts::WordsHelper
  def word_row(word)
    toggle_link_text = word.memorized? ? t("wordrobe.button.forget") : t("wordrobe.button.memorize")
    toggle_link = link_to(
      toggle_link_text,
      accounts_wordrobe_toggle_memorize_path(word, :page => params[:page]),
      :remote => true,
      "data-type" => "html",
      :method => :put,
      :class => "update_wordrobe"
    )
    remove_link_text = "remove"
    remove_link = link_to(
      remove_link_text,
      accounts_wordrobe_destroy_path(word, :page => params[:page]),
      :remote => true,
      "data-type" => "html",
      :method => :delete,
      :class => "update_wordrobe"
    )
    "<td>#{toggle_link}</td><td>#{word.word.name}</td><td>(#{word.register_count})</td><td>#{remove_link}</td>"
  end
end
