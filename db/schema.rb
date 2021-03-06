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

ActiveRecord::Schema.define(version: 2021_12_01_194327) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "client_profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "city"
    t.string "state"
    t.string "residential_address"
    t.integer "residential_number"
    t.string "age_rating"
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cep"
    t.string "cpf"
    t.string "token"
    t.integer "client_token_status", default: 5
    t.index ["client_id"], name: "index_client_profiles_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "content_playlists", force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "playlist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_content_playlists_on_plan_id"
    t.index ["playlist_id"], name: "index_content_playlists_on_playlist_id"
  end

  create_table "content_streamers", force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "streamer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_content_streamers_on_plan_id"
    t.index ["streamer_id"], name: "index_content_streamers_on_streamer_id"
  end

  create_table "credit_card_settings", force: :cascade do |t|
    t.string "nickname"
    t.string "encrypted_digits"
    t.string "token"
    t.integer "customer_payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_payment_method_id"], name: "index_credit_card_settings_on_customer_payment_method_id"
  end

  create_table "customer_payment_methods", force: :cascade do |t|
    t.string "pix_token"
    t.string "boleto_token"
    t.integer "client_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_profile_id"], name: "index_customer_payment_methods_on_client_profile_id"
  end

  create_table "game_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_game_categories_on_admin_id"
    t.index ["name"], name: "index_game_categories_on_name", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_games_on_admin_id"
    t.index ["name"], name: "index_games_on_name", unique: true
  end

  create_table "games_game_categories", force: :cascade do |t|
    t.integer "game_category_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_category_id"], name: "index_games_game_categories_on_game_category_id"
    t.index ["game_id"], name: "index_games_game_categories_on_game_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plan_token"
    t.integer "plan_status", default: 0
  end

  create_table "playlist_streamers", force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "streamer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["playlist_id"], name: "index_playlist_streamers_on_playlist_id"
    t.index ["streamer_id"], name: "index_playlist_streamers_on_streamer_id"
  end

  create_table "playlist_videos", force: :cascade do |t|
    t.integer "video_id", null: false
    t.integer "playlist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["playlist_id"], name: "index_playlist_videos_on_playlist_id"
    t.index ["video_id"], name: "index_playlist_videos_on_video_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_playlists_on_admin_id"
    t.index ["name"], name: "index_playlists_on_name", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.boolean "loose"
    t.decimal "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "video_id", null: false
    t.index ["video_id"], name: "index_prices_on_video_id"
  end

  create_table "streamer_profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "facebook"
    t.string "instagram"
    t.string "twitter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "streamer_id", null: false
    t.integer "status", default: 0
    t.index ["streamer_id"], name: "index_streamer_profiles_on_streamer_id"
  end

  create_table "streamers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_status", default: 5
    t.index ["email"], name: "index_streamers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_streamers_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.integer "streamer_id", null: false
    t.integer "status", default: 0
    t.string "feed_back"
    t.integer "game_id", null: false
    t.integer "visualization", default: 0
    t.string "single_video_token"
    t.index ["game_id"], name: "index_videos_on_game_id"
    t.index ["link"], name: "index_videos_on_link", unique: true
    t.index ["streamer_id"], name: "index_videos_on_streamer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "client_profiles", "clients"
  add_foreign_key "content_playlists", "plans"
  add_foreign_key "content_playlists", "playlists"
  add_foreign_key "content_streamers", "plans"
  add_foreign_key "content_streamers", "streamers"
  add_foreign_key "credit_card_settings", "customer_payment_methods"
  add_foreign_key "customer_payment_methods", "client_profiles"
  add_foreign_key "game_categories", "admins"
  add_foreign_key "games", "admins"
  add_foreign_key "games_game_categories", "game_categories"
  add_foreign_key "games_game_categories", "games"
  add_foreign_key "playlist_streamers", "playlists"
  add_foreign_key "playlist_streamers", "streamers"
  add_foreign_key "playlist_videos", "playlists"
  add_foreign_key "playlist_videos", "videos"
  add_foreign_key "playlists", "admins"
  add_foreign_key "prices", "videos"
  add_foreign_key "streamer_profiles", "streamers"
  add_foreign_key "videos", "games"
  add_foreign_key "videos", "streamers"
end
