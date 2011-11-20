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

ActiveRecord::Schema.define(:version => 20111022184532) do

  create_table "accounts", :force => true do |t|
    t.string   "facebook_uid",                        :null => false
    t.string   "twitter_uid"
    t.string   "first_name",                          :null => false
    t.string   "last_name",                           :null => false
    t.string   "nickname"
    t.boolean  "display_memorized", :default => true
    t.boolean  "boolean",           :default => true
    t.boolean  "show_profile",      :default => true
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["created_at"], :name => "index_accounts_on_created_at"
  add_index "accounts", ["facebook_uid"], :name => "index_accounts_on_facebook_uid", :unique => true
  add_index "accounts", ["first_name"], :name => "index_accounts_on_first_name"
  add_index "accounts", ["last_name"], :name => "index_accounts_on_last_name"
  add_index "accounts", ["nickname"], :name => "index_accounts_on_nickname"
  add_index "accounts", ["twitter_uid"], :name => "index_accounts_on_twitter_uid", :unique => true
  add_index "accounts", ["updated_at"], :name => "index_accounts_on_updated_at"

  create_table "wordrobes", :force => true do |t|
    t.integer  "account_id",                          :null => false
    t.integer  "word_id",                             :null => false
    t.integer  "translated_count", :default => 0,     :null => false
    t.boolean  "memorize",         :default => false
    t.integer  "rating"
    t.datetime "memorized_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wordrobes", ["account_id", "word_id"], :name => "index_wordrobes_on_account_id_and_word_id", :unique => true
  add_index "wordrobes", ["created_at"], :name => "index_wordrobes_on_created_at"
  add_index "wordrobes", ["updated_at"], :name => "index_wordrobes_on_updated_at"

  create_table "words", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "translated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["name"], :name => "index_words_on_name", :unique => true
  add_index "words", ["translated"], :name => "index_words_on_translated"

end
