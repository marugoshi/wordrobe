class Accounts::WordrobesController < ApplicationController
  before_filter :login_required

  def create
    word = Word.where("name = ?", params[:word]).first()
    return redirect_to oops_no_word_path unless word
    word_belonged = current_account.wordrobes.where("word_id = ?", word.id).first()
    word_belonged = Wordrobe.new(:account_id => current_account.id, :word_id => word.id) unless word_belonged
    word_belonged.register_count += 1
    word_belonged.save!
    redirect_to dashboard_path
  end

  def toggle_memorize_with_ajax
    # TODO raise exception if word_belonged does not exist.
    word_belonged = current_account.wordrobes.where("id = ?", params[:wordrobe_id]).first()
    word_belonged.memorized = !word_belonged.memorized?
    word_belonged.save!
    @wordrobe = current_account.wordrobes.send(params[:for])
    render :partial => "accounts/wordrobes/wordrobe"
  end

  def destroy_with_ajax
    word_belonged = current_account.wordrobes.where("id = ?", params[:wordrobe_id]).first()
    word_belonged.delete
    @wordrobe = current_account.wordrobes.send(params[:for])
    render :partial => "accounts/wordrobes/wordrobe"
  end
end
