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

ActiveRecord::Schema.define(version: 2018_08_15_222326) do

  create_table "case_event_associations", force: :cascade do |t|
    t.integer "event_id"
    t.integer "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_event_associations_on_case_id"
    t.index ["event_id"], name: "index_case_event_associations_on_event_id"
  end

  create_table "case_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", force: :cascade do |t|
    t.integer "case_type_id"
    t.string "name"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_type_id"], name: "index_cases_on_case_type_id"
  end

  create_table "comment_item_associations", force: :cascade do |t|
    t.integer "event_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comment_item_associations_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "buildup"
    t.datetime "removel"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "manufacturer"
    t.string "model"
    t.integer "item_id"
    t.integer "case_id"
    t.date "date_of_purchase"
    t.decimal "price"
    t.string "serial_number"
    t.boolean "broken", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_items_on_case_id"
    t.index ["item_id"], name: "index_items_on_item_id"
  end

# Could not dump table "transports" because of following StandardError
#   Unknown type 'event' for column 'destination_event'

end
