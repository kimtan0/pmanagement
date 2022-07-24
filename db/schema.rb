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

ActiveRecord::Schema.define(version: 2022_07_24_091754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "units", force: :cascade do |t|
    t.integer "unit_number"
    t.string "unit_address"
    t.string "unit_type"
    t.string "storey"
    t.string "tenure"
    t.string "floor_size"
    t.string "land_size"
    t.integer "washroom"
    t.integer "bedroom"
    t.string "username"
    t.string "password_digest"
    t.string "tenant_name"
    t.string "tenant_phone_number"
    t.string "tenant_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
