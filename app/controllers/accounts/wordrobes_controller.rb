class Accounts::WordrobesController < ApplicationController
  before_filter :login_required
  autocomplete :word, :name, :limit => 17

  def create_with_ajax
    word = Word.where("name = ?", params[:word]).first()
    unless word
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.no_word")
      return render :partial => "accounts/wordrobes/error"
    end

    word_belonged = current_account.wordrobes.where("word_id = ?", word.id).first()
    unless word_belonged
      word_belonged = Wordrobe.new(:account_id => current_account.id, :word_id => word.id) 
      word_belonged.save!
    end
    # TODO: implement for if already stored data

    display_wordrobe(params[:page])
  end

  def wordrobes_with_ajax
    display_wordrobe(params[:page])
  end

  def toggle_memorize_with_ajax
    word_belonged = get_word_belonged
    unless word_belonged.memorize?
      word_belonged.memorize = true
      word_belonged.memorized_at = Time.now
      word_belonged.save!
    end
    # TODO: implement for if already memorized data

    display_wordrobe(params[:page])
  end

  def toggle_translate_with_ajax
    word_belonged = get_word_belonged

    if params[:translated] == "true" && !word_belonged.memorized_at
      begin
        response = RestClient.get Settings.translate_url, :params => Settings.translated_params.merge(:text => word_belonged.word.name)
      rescue
        @title = t("accounts.wordrobes.error.title")
        @body = t("accounts.wordrobes.error.ms_is_not_available")
        return render :partial => "accounts/wordrobes/error"
      end
      @translated = Nokogiri::XML(response).child.child.to_html()
      word_belonged.translated_count += 1
      word_belonged.save!
    end

    display_wordrobe(params[:page])
  end

  private
  def display_wordrobe(page=0)
    @wordrobe = current_account.wordrobes.for_dashboard(page)
    unless @wordrobe
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end
    render :partial => "accounts/wordrobes/wordrobe"
  end

  def get_word_belonged
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:id]).first()
    unless word_belonged
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.not_in_wordrobe")
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
