# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_02_142829) do
  create_table "case_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "cases", force: :cascade do |t|
    t.integer "case_type_id"
    t.string "name"
    t.string "acronym"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_type_id"], name: "index_cases_on_case_type_id"
  end

  create_table "check_list_items", force: :cascade do |t|
    t.integer "check_list_id"
    t.integer "item_id"
    t.integer "case_id"
    t.boolean "broken"
    t.boolean "missing"
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "checked"
    t.index ["case_id"], name: "index_check_list_items_on_case_id"
    t.index ["check_list_id"], name: "index_check_list_items_on_check_list_id"
    t.index ["item_id"], name: "index_check_list_items_on_item_id"
  end

  create_table "check_lists", force: :cascade do |t|
    t.text "comment"
    t.string "advisor"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "checked"
  end

  create_table "event_cases", force: :cascade do |t|
    t.integer "event_id"
    t.integer "case_id"
    t.integer "transport_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "check_list_id"
    t.index ["case_id"], name: "index_event_cases_on_case_id"
    t.index ["check_list_id"], name: "index_event_cases_on_check_list_id"
    t.index ["event_id"], name: "index_event_cases_on_event_id"
    t.index ["transport_id"], name: "index_event_cases_on_transport_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "buildup", precision: nil
    t.datetime "removel", precision: nil
    t.string "location"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "item_comments", force: :cascade do |t|
    t.integer "item_id"
    t.text "comment"
    t.string "author"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["item_id"], name: "index_item_comments_on_item_id"
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
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
    t.boolean "missing", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "item_type_id"
    t.integer "location_item_id"
    t.boolean "deleted", default: false
    t.index ["case_id"], name: "index_items_on_case_id"
    t.index ["item_id"], name: "index_items_on_item_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["location_item_id"], name: "index_items_on_location_item_id"
  end

  create_table "transports", force: :cascade do |t|
    t.text "source_address"
    t.text "destination_address"
    t.datetime "pickup_time", precision: nil
    t.datetime "delivery_time", precision: nil
    t.integer "pickup_timeframe"
    t.integer "delivery_timeframe"
    t.text "pickup_contact"
    t.text "delivery_contact"
    t.boolean "quotation", default: false
    t.boolean "ordered", default: false
    t.string "carrier"
    t.integer "destination_event_id"
    t.integer "source_event_id"
    t.string "tracking_number"
    t.integer "shipment_id"
    t.string "delivery_state"
    t.datetime "actual_pickup_time", precision: nil
    t.datetime "actual_delivery_time", precision: nil
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid"
  end
end
