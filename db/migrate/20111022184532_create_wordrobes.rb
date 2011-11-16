class CreateWordrobes < ActiveRecord::Migration
  def change
    create_table :wordrobes do |t|
      t.integer :account_id, :null => false
      t.integer :word_id, :null => false
      t.integer :register_count, :null => false, :default => 0
      t.boolean :memorize, :default => false
      t.integer :rating
      t.timestamps
    end
    add_index :wordrobes, [:account_id, :word_id], :unique => true
    add_index :wordrobes, :register_count
    add_index :wordrobes, :created_at
    add_index :wordrobes, :updated_at
  end
end
