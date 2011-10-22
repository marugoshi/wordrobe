# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111022100135) do

  create_table "accounts", :force => true do |t|
    t.integer  "uid",        :null => false
    t.string   "name",       :null => false
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["created_at"], :name => "index_accounts_on_created_at"
  add_index "accounts", ["name"], :name => "index_accounts_on_name"
  add_index "accounts", ["nickname"], :name => "index_accounts_on_nickname"
  add_index "accounts", ["uid"], :name => "index_accounts_on_uid", :unique => true
  add_index "accounts", ["updated_at"], :name => "index_accounts_on_updated_at"

end
