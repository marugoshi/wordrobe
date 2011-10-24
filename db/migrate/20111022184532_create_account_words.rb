class CreateAccountWords < ActiveRecord::Migration
  def change
    create_table :account_words do |t|
      t.integer :account_id, :null => false
      t.integer :word_id, :null => false
      t.integer :register_count, :null => false, :default => 0
      t.boolean :memorized, :null => false, :default => false
      t.timestamps
    end
    add_index :account_words, [:account_id, :word_id], :unique => true
    add_index :account_words, :register_count
    add_index :account_words, :created_at
    add_index :account_words, :updated_at
  end
end
