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
    word_belonged = Wordrobe.new(:account_id => current_account.id, :word_id => word.id) unless word_belonged
    word_belonged.save!
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    render :partial => "accounts/wordrobes/wordrobe"
  end

  def wordrobes_with_ajax
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])

    unless @wordrobe
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end

    render :partial => "accounts/wordrobes/wordrobe"
    end

  def toggle_memorize_with_ajax
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:id]).first()

    unless word_belonged
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end

    word_belonged.memorize = !word_belonged.memorize?
    word_belonged.save!
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    render :partial => "accounts/wordrobes/wordrobe"
  end

  def toggle_translate_with_ajax
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:id]).first()

    unless word_belonged
      @title = t("accounts.wordrobes.error.title")
      @body = t("accounts.wordrobes.error.not_in_wordrobe")
      return render :partial => "accounts/wordrobes/error"
    end

    if params[:translated] == "true"
      begin
        response = RestClient.get Settings.translate_url, :params => Settings.translated_params.merge(:text => word_belonged.word.name)
      rescue
        @title = t("accounts.wordrobes.error.title")
        @body = t("accounts.wordrobes.error.ms_is_not_available")
        return render :partial => "accounts/wordrobes/error"
      end
      @translated = Nokogiri::XML(response).child.child.to_html()
    end

    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    render :partial => "accounts/wordrobes/wordrobe"
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
