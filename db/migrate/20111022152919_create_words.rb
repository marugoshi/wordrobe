class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name, :null => false
      t.string :translated
      t.timestamps
    end
    add_index :words, :name, :unique => true
    add_index :words, :translated
  end
end
