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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150601033018) do

  create_table "access_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "booking_rooms", force: :cascade do |t|
    t.integer  "booking_id",       limit: 4
    t.integer  "room_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "akerun_grant_key", limit: 255
  end

  add_index "booking_rooms", ["booking_id", "room_id"], name: "index_booking_rooms_on_booking_id_and_room_id", unique: true, using: :btree

  create_table "bookings", force: :cascade do |t|
    t.string   "key",                  limit: 255
    t.integer  "travel_agency_id",     limit: 4
    t.integer  "hotel_id",             limit: 4
    t.integer  "guest_info_id",        limit: 4
    t.string   "plan",                 limit: 255
    t.datetime "checkin"
    t.datetime "checkout"
    t.string   "no",                   limit: 255
    t.string   "status",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "agency_booking_key",   limit: 255
    t.string   "temporary_akerun_key", limit: 255
    t.integer  "guest_id",             limit: 4
  end

  add_index "bookings", ["agency_booking_key", "hotel_id", "travel_agency_id"], name: "booking1", using: :btree
  add_index "bookings", ["guest_id"], name: "index_bookings_on_guest_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "guest_infos", force: :cascade do |t|
    t.string   "key",          limit: 255
    t.integer  "guest_id",     limit: 4
    t.string   "name",         limit: 255
    t.string   "zip",          limit: 255
    t.string   "address1",     limit: 255
    t.string   "address2",     limit: 255
    t.string   "phone",        limit: 255
    t.string   "email",        limit: 255
    t.string   "sex",          limit: 255
    t.string   "receipt_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "guests", force: :cascade do |t|
    t.string   "key",             limit: 255
    t.string   "akerun_user_key", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "key",              limit: 255
    t.integer  "company_id",       limit: 4
    t.string   "name",             limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "akerun_hotel_key", limit: 255
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.integer  "hotel_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "akerun_key", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "touch_points", force: :cascade do |t|
    t.string   "key",         limit: 255
    t.string   "name",        limit: 255
    t.integer  "hotel_id",    limit: 4
    t.string   "akerun_key",  limit: 255
    t.string   "device_type", limit: 255, default: "checkin"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "touch_points", ["akerun_key"], name: "index_touch_points_on_akerun_key", using: :btree

  create_table "travel_agencies", force: :cascade do |t|
    t.string   "key",         limit: 255
    t.string   "name",        limit: 255
    t.integer  "order_index", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_requests", force: :cascade do |t|
    t.string   "key",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.integer  "hotel_id",         limit: 4
    t.integer  "travel_agency_id", limit: 4
    t.integer  "booking_id",       limit: 4
    t.integer  "guest_id",         limit: 4
    t.integer  "guest_info_id",    limit: 4
    t.text     "mail_note",        limit: 65535
    t.integer  "count",            limit: 4,     default: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "user_requests", ["booking_id"], name: "index_user_requests_on_booking_id", using: :btree
  add_index "user_requests", ["guest_id"], name: "index_user_requests_on_guest_id", using: :btree
  add_index "user_requests", ["guest_info_id"], name: "index_user_requests_on_guest_info_id", using: :btree
  add_index "user_requests", ["hotel_id"], name: "index_user_requests_on_hotel_id", using: :btree
  add_index "user_requests", ["key", "hotel_id"], name: "index_user_requests_on_key_and_hotel_id", using: :btree
  add_index "user_requests", ["travel_agency_id"], name: "index_user_requests_on_travel_agency_id", using: :btree

  add_foreign_key "bookings", "guests"
  add_foreign_key "user_requests", "bookings"
  add_foreign_key "user_requests", "guest_infos"
  add_foreign_key "user_requests", "guests"
  add_foreign_key "user_requests", "hotels"
  add_foreign_key "user_requests", "travel_agencies"
end
