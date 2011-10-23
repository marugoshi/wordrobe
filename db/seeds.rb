file = Rails.root.join("db/masters/words.txt")
File.open(file) {|f|
  ActiveRecord::Base.transaction do
    f.each { |word|
      next unless word
      Word.create!(:name => word.strip)
    }
  end
}
