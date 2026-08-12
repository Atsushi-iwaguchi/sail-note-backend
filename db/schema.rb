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

ActiveRecord::Schema[8.1].define(version: 2026_08_12_084624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "practice_record_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["practice_record_id"], name: "index_comments_on_practice_record_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "monthly_goals", force: :cascade do |t|
    t.integer "achievement_rate"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.date "goal_date", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_monthly_goals_on_user_id"
  end

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

  create_table "race_results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "race_number", null: false
    t.integer "score", null: false
    t.bigint "tournament_entry_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_entry_id"], name: "index_race_results_on_tournament_entry_id"
  end

  create_table "tournament_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "overall_ranking", null: false
    t.text "reflection"
    t.bigint "tournament_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["tournament_id"], name: "index_tournament_entries_on_tournament_id"
    t.index ["user_id"], name: "index_tournament_entries_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.integer "boats_count"
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.string "name", null: false
    t.integer "race_count"
    t.date "start_date", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "practice_records"
  add_foreign_key "comments", "users"
  add_foreign_key "monthly_goals", "users"
  add_foreign_key "practice_records", "users"
  add_foreign_key "race_results", "tournament_entries"
  add_foreign_key "tournament_entries", "tournaments"
  add_foreign_key "tournament_entries", "users"
end
