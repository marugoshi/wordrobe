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

  def memorize
  end

  def forget
  end
end
