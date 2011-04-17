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

ActiveRecord::Schema.define(:version => 20110206162619) do

  create_table "abouts", :force => true do |t|
    t.text     "info"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "login",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["login"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "collections", :force => true do |t|
    t.string   "name_en"
    t.string   "icon_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group"
    t.text     "name_ru"
    t.text     "name_de"
  end

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.text     "text"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.text     "info"
    t.float    "lat"
    t.float    "long"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "front_pages", :force => true do |t|
    t.text     "header_en"
    t.text     "footer_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "header_ru"
    t.text     "header_de"
    t.text     "footer_ru"
    t.text     "footer_de"
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "file_ext"
    t.integer  "order"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", :force => true do |t|
    t.string   "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
