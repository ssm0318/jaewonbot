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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181112150731) do

  create_table "chats", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
    t.index [nil], name: "index_chats_on_user"
  end

  create_table "logs", force: :cascade do |t|
    t.string "user_key"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.string "content"
    t.string "content_type"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type"], name: "index_responses_on_content_type"
    t.index ["user_id"], name: "index_responses_on_user_id"
    t.index [nil], name: "index_responses_on_user"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
