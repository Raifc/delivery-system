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

ActiveRecord::Schema[7.0].define(version: 2022_05_17_034748) do
  create_table "add_addressable_to_addresses", force: :cascade do |t|
    t.string "addressable_type", null: false
    t.integer "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_add_addressable_to_addresses_on_addressable"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "full_address"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "addressable_type"
    t.integer "addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "companies", force: :cascade do |t|
    t.string "corporate_name"
    t.string "trading_name"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
  end

  create_table "email_domains", force: :cascade do |t|
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domainable_type"
    t.integer "domainable_id"
    t.index ["domainable_type", "domainable_id"], name: "index_email_domains_on_domainable"
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.decimal "height"
    t.decimal "width"
    t.decimal "depth"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.integer "load_capacity"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_vehicles_on_company_id"
  end

  add_foreign_key "vehicles", "companies"
end
