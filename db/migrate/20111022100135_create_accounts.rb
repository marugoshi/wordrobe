class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :uid, :null => false
      t.string :name, :null => false
      t.string :nickname
      t.timestamps
    end
    add_index :accounts, :uid, :unique => true
    add_index :accounts, :name
    add_index :accounts, :nickname
    add_index :accounts, :created_at
    add_index :accounts, :updated_at
  end
end
