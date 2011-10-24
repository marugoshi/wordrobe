class Accounts::WordsController < ApplicationController
  before_filter :login_required

  def create
    word = Word.where("name = ?", params[:word]).first()
    return redirect_to oops_no_word_path unless word
    word_belonged = AccountWord.by(current_account.id).where("word_id = ?", word.id).first()
    word_belonged = AccountWord.new(:account_id => current_account.id, :word_id => word.id) unless word_belonged
    word_belonged.register_count += 1
    word_belonged.save!
    redirect_to dashboard_path
  end

  def toggle_memorize
    # TODO raise exception if word_belonged does not exist.
    word_belonged = AccountWord.by(current_account.id).where("id = ?", params[:word_id]).first()
    word_belonged.memorized = params[:memorized]
    word_belonged.save!
    if params[:from] == "dashboard"
      @words_belonged = AccountWord.by(current_account.id).for_dashboard
    else
      @words_belonged = AccountWord.by(current_account.id)
    end
    render :partial => "accounts/words/words_belonged"
  end
end
