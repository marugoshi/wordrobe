class CreateWordContainers < ActiveRecord::Migration
  def change
    create_table :word_containers do |t|
      t.integer :account_id, :null => false
      t.integer :word_id, :null => false
      t.integer :translated_count, :null => false, :default => 0
      t.boolean :memorize, :default => false
      t.integer :rating
      t.datetime :memorized_at
      t.timestamps
    end
    add_index :word_containers, [:account_id, :word_id], :unique => true
    add_index :word_containers, :created_at
    add_index :word_containers, :updated_at
  end
end
