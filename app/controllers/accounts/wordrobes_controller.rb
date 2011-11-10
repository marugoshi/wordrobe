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

  def wordrobe_with_ajax
    wordrobe
  end

  def rating_with_ajax
  #   # TODO raise exception if word_belonged does not exist.
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:wordrobe_id]).first()
    word_belonged.rating = params[:rating]
    word_belonged.save!
    wordrobe
  end

  # def toggle_memorize_with_ajax
  #   # TODO raise exception if word_belonged does not exist.
  #   word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:wordrobe_id]).first()
  #   word_belonged.memorized = !word_belonged.memorized?
  #   word_belonged.save!
  #   wordrobe
  # end

  # def destroy_with_ajax
  #   # TODO raise exception if word_belonged does not exist.
  #   word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:wordrobe_id]).first()
  #   word_belonged.delete
  #   wordrobe
  # end

  private
  def wordrobe
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    @total = current_account.wordrobes.count
    render :partial => "accounts/wordrobes/wordrobe"
  end
end
