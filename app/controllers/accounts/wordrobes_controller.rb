class Accounts::WordrobesController < ApplicationController
  before_filter :login_required
  autocomplete :word, :name, :limit => 17

  def create_with_ajax
    page = params[:page]

    word = Word.where("name = ?", params[:word]).first()
    unless word
      @error = t("layouts.error_modal.message.no_word")
    else
      word_belonged = current_account.wordrobes.where("word_id = ?", word.id).first()
      if word_belonged
        @error = t("layouts.error_modal.message.already_in_wordrobe")
      else
        page = 0
        word_belonged = Wordrobe.new(:account_id => current_account.id, :word_id => word.id) 
        word_belonged.save!
      end
    end

    display_wordrobe(page)
  end

  def wordrobes_with_ajax
    display_wordrobe(params[:page])
  end

  def toggle_memorize_with_ajax
    word_belonged = get_word_belonged
    if word_belonged.memorize?
      @error = t("layouts.error_modal.message.already_memorzied")
    else
      word_belonged.memorize = true
      word_belonged.memorized_at = Time.now
      word_belonged.save!
    end

    display_wordrobe(params[:page])
  end

  def toggle_translate_with_ajax
    word_belonged = get_word_belonged

    if word_belonged.memorize?
      @error = t("layouts.error_modal.message.already_translated")
    else
      if params[:translated] == "true"
        begin
          response = RestClient.get Settings.translate_url, :params => Settings.translated_params.merge(:text => word_belonged.word.name)
        rescue
          @fatal_error_title = t("accounts.wordrobes.error.title")
          @fatal_error_body = t("accounts.wordrobes.error.ms_is_not_available")
          return render :partial => "accounts/wordrobes/error"
        end
        @translated = Nokogiri::XML(response).child.child.to_html()
        word_belonged.translated_count += 1
        word_belonged.save!
      end
    end


    display_wordrobe(params[:page])
  end

  private
  def display_wordrobe(page=0)
    @wordrobe = current_account.wordrobes.for_dashboard(page)
    unless @wordrobe
      @fatal_error_title = t("accounts.wordrobes.error.title")
      @fatal_error_body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end
    render :partial => "accounts/wordrobes/wordrobe"
  end

  def get_word_belonged
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:id]).first()
    unless word_belonged
      @fatal_error_title = t("accounts.wordrobes.error.title")
      @fatal_error_body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end
    word_belonged
  end

  # def rating_with_ajax
  # #   # TODO raise exception if word_belonged does not exist.
  #   word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:wordrobe_id]).first()
  #   word_belonged.rating = params[:rating]
  #   word_belonged.save!
  #   wordrobe
  # end

  # def destroy_with_ajax
  #   # TODO raise exception if word_belonged does not exist.
  #   word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:wordrobe_id]).first()
  #   word_belonged.delete
  #   wordrobe
  # end
end
