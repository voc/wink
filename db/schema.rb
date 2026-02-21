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

ActiveRecord::Schema[8.1].define(version: 2026_02_21_113247) do
  create_table "case_types", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string "acronym"
    t.integer "case_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_type_id"], name: "index_cases_on_case_type_id"
  end

  create_table "check_list_items", force: :cascade do |t|
    t.boolean "broken", default: false, null: false
    t.integer "case_id"
    t.integer "check_list_id"
    t.boolean "checked", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "item_id"
    t.boolean "missing", default: false, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_id"], name: "index_check_list_items_on_case_id"
    t.index ["check_list_id"], name: "index_check_list_items_on_check_list_id"
    t.index ["item_id"], name: "index_check_list_items_on_item_id"
  end

  create_table "check_lists", force: :cascade do |t|
    t.string "advisor"
    t.boolean "checked", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "event_cases", force: :cascade do |t|
    t.integer "case_id"
    t.integer "check_list_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "event_id"
    t.integer "transport_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_id"], name: "index_event_cases_on_case_id"
    t.index ["check_list_id"], name: "index_event_cases_on_check_list_id"
    t.index ["event_id"], name: "index_event_cases_on_event_id"
    t.index ["transport_id"], name: "index_event_cases_on_transport_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "buildup", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.date "end_date"
    t.string "location"
    t.string "name"
    t.datetime "removel", precision: nil
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "item_comments", force: :cascade do |t|
    t.string "author"
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "item_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["item_id"], name: "index_item_comments_on_item_id"
  end

  create_table "item_types", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_item_types_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.boolean "broken", default: false, null: false
    t.integer "case_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "date_of_purchase"
    t.boolean "deleted", default: false, null: false
    t.string "description"
    t.string "inventory_number"
    t.integer "item_id"
    t.integer "item_type_id"
    t.integer "location_item_id"
    t.string "manufacturer"
    t.boolean "missing", default: false, null: false
    t.string "model"
    t.string "name"
    t.decimal "price"
    t.string "serial_number"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_id"], name: "index_items_on_case_id"
    t.index ["inventory_number"], name: "index_items_on_inventory_number", unique: true
    t.index ["item_id"], name: "index_items_on_item_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
  end

  create_table "transports", force: :cascade do |t|
    t.datetime "actual_delivery_time", precision: nil
    t.datetime "actual_pickup_time", precision: nil
    t.string "carrier"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "delivery_contact"
    t.string "delivery_state"
    t.datetime "delivery_time", precision: nil
    t.integer "delivery_timeframe"
    t.text "destination_address"
    t.integer "destination_event_id"
    t.boolean "ordered", default: false, null: false
    t.text "pickup_contact"
    t.datetime "pickup_time", precision: nil
    t.integer "pickup_timeframe"
    t.boolean "quotation", default: false, null: false
    t.integer "shipment_id"
    t.text "source_address"
    t.integer "source_event_id"
    t.string "tracking_number"
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end
end
