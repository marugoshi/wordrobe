# -*- coding: utf-8 -*-
module Accounts::WordsHelper
  def paginate_next(wordrobe)
    paginate(
      wordrobe,
      :remote => true,
      :theme => "wordrobe_next",
      :params => { :controller => "/accounts/wordrobes", :action => "index_with_ajax"}
    )
  end

  def paginate_prev(wordrobe)
    paginate(
      wordrobe,
      :remote => true,
      :theme => "wordrobe_prev",
      :params => { :controller => "/accounts/wordrobes", :action => "index_with_ajax" }
    )
  end

  def remove_link(word)
    link_to(
      image_tag("/assets/common/wordrobe/remove.png", :width => "29", :height => "29", :alt => t("wordrobe.button.remove")),
      accounts_wordrobe_destroy_path(word, :page => params[:page]),
      :remote => true,
      "data-type" => "html",
      :method => :delete,
      :class => "update_wordrobe"
    )
  end

  def toggle_link(word)
    raw(memorize_span(word) +
    link_to(
      memorize_image_tag(word),
      accounts_wordrobe_toggle_memorize_path(word, :page => params[:page]),
      :remote => true,
      "data-type" => "html",
      :method => :put,
      :class => "update_wordrobe"
    ) + 
    "</span>")
  end

  def rating(word)
    str = <<"EOF"
    <input name="star1" type="radio" class="star"/>
    <input name="star1" type="radio" class="star"/>
    <input name="star1" type="radio" class="star" disabled="disabled"/>
    <input name="star1" type="radio" class="star" disabled="disabled" checked="checked"/>
    <input name="star1" type="radio" class="star"/>
EOF
    raw(str)
  end

  private
  def memorize_image_tag(word)
    word.memorized? ?
      image_tag("/assets/common/wordrobe/memorize_on.png", :width => "31", :height => "30", :alt => t("wordrobe.button.forget")) :
      image_tag("/assets/common/wordrobe/memorize_off.png", :width => "31", :height => "30", :alt => t("wordrobe.button.memorize"))
  end

  def memorize_span(word)
    word.memorized? ? "<span id=\"forget\">" : "<span id=\"memorize\">"
  end
end
