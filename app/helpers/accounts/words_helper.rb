module Accounts::WordsHelper
  def word_row(word)
    link_text = word.memorized? ? t("word.button.forget") : t("word.button.memorize")
    link = link_to(
      link_text,
      accounts_word_toggle_memorize_path(word, :memorized => !word.memorized?, :from => "dashboard"),
      :method => :put,
      :remote => true,
      "data-type" => "html",
      "data-update" =>  "word_list"
    )
    "<li>#{link}&nbsp;#{word.word.name}&nbsp;(#{word.register_count})"
  end
end
