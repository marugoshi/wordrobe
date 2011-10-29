class Accounts::WordsController < ApplicationController
  before_filter :login_required

  def create
    word = Word.where("name = ?", params[:word]).first()
    return redirect_to oops_no_word_path unless word
    word_belonged = current_account.account_words.where("word_id = ?", word.id).first()
    word_belonged = AccountWord.new(:account_id => current_account.id, :word_id => word.id) unless word_belonged
    word_belonged.register_count += 1
    word_belonged.save!
    redirect_to dashboard_path
  end

  def toggle_memorize_with_ajax
    # TODO raise exception if word_belonged does not exist.
    word_belonged = current_account.account_words.where("id = ?", params[:word_id]).first()
    word_belonged.memorized = !word_belonged.memorized?
    word_belonged.save!
    @wordrobe = current_account.account_words
    render :partial => "accounts/words/wordrobe"
  end

  def destroy_with_ajax
    word_belonged = current_account.account_words.where("id = ?", params[:word_id]).first()
    word_belonged.delete
    @wordrobe = current_account.account_words
    render :partial => "accounts/words/wordrobe"
  end
end
