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

ActiveRecord::Schema[8.1].define(version: 2026_07_22_082752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "practice_records", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "mast_bend"
    t.integer "mast_rake"
    t.integer "mast_spreader_angle"
    t.integer "mast_spreader_length"
    t.integer "mast_tension"
    t.integer "max_wind_speed"
    t.integer "min_wind_speed"
    t.date "practice_date", null: false
    t.text "reflection"
    t.float "temperature"
    t.integer "tide"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "weather"
    t.string "wind_direction"
    t.index ["user_id"], name: "index_practice_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "boat_class"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
  end

  add_foreign_key "practice_records", "users"
end
