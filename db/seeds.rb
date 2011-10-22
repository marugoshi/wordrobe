file = Rails.root.join("db/masters/words.txt")
File.open(file) {|f|
  f.each { |word|
    ActiveRecord::Base.transaction do
      Word.create!(:word => word.strip)
    end
  }
}
