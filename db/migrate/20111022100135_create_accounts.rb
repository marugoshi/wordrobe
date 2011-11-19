class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :uid, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :nickname
      t.boolean :display_memorized, :boolean, :default => true
      t.boolean :show_profile, :boolean, :default => true
      t.text :comment
      t.timestamps
    end
    add_index :accounts, :uid, :unique => true
    add_index :accounts, :first_name
    add_index :accounts, :last_name
    add_index :accounts, :nickname
    add_index :accounts, :created_at
    add_index :accounts, :updated_at
  end
end
