# -*- coding: utf-8 -*-
module Accounts::WordsHelper
  def word_row(word)
    toggle_link_text = word.memorized? ? t("wordrobe.button.forget") : t("wordrobe.button.memorize")
    toggle_link = link_to(
      toggle_link_text,
      accounts_wordrobe_toggle_memorize_path(word),
      :remote => true,
      "data-type" => "html",
      :method => :put,
      :class => "update_wordrobe"
    )
    remove_link_text = "remove"
    remove_link = link_to(
      remove_link_text,
      accounts_wordrobe_destroy_path(word),
      :remote => true,
      "data-type" => "html",
      :method => :delete,
      :class => "update_wordrobe"
    )
    "<li>#{toggle_link}&nbsp;#{word.word.name}&nbsp;(#{word.register_count})&nbsp;#{remove_link}</li>"
  end
end
