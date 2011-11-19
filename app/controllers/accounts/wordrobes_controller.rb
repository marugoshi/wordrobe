class Accounts::WordrobesController < ApplicationController
  before_filter :login_required
  autocomplete :word, :name, :limit => 17

  def create_with_ajax
    word = Word.where("name = ?", params[:word]).first()
    return render :partial => "accounts/wordrobes/oops_no_word" unless word
    word_belonged = current_account.wordrobes.where("word_id = ?", word.id).first()
    word_belonged = Wordrobe.new(:account_id => current_account.id, :word_id => word.id) unless word_belonged
    word_belonged.register_count += 1
    word_belonged.save!
    wordrobe
  end

  def wordrobes_with_ajax
    wordrobe
  end

  def toggle_memorize_with_ajax
    word_belonged = current_account.wordrobes.where("wordrobes.id = ?", params[:id]).first()
    return render :partial => "accounts/wordrobes/oops_no_word" unless word_belonged
    word_belonged.memorize = !word_belonged.memorize?
    word_belonged.save!
    wordrobe
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

  private
  def wordrobe
    @wordrobe = current_account.wordrobes.for_dashboard(params[:page])
    @total = current_account.wordrobes.count
    render :partial => "accounts/wordrobes/wordrobe"
  end
end
