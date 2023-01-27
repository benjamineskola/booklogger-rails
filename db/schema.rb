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

ActiveRecord::Schema[7.0].define(version: 2023_01_27_094154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "forenames"
    t.string "surname"
    t.string "preferred_forenames"
    t.boolean "surname_first"
    t.integer "gender"
    t.boolean "poc"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "primary_identity_id"
    t.index ["primary_identity_id"], name: "index_authors_on_primary_identity_id"
  end

  create_table "authorships", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.string "role"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authorships_on_author_id"
    t.index ["book_id"], name: "index_authorships_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.bigint "first_author_id"
    t.string "first_author_role"
    t.integer "first_published", limit: 2
    t.integer "edition_published", limit: 2
    t.string "publisher"
    t.integer "page_count", limit: 2
    t.string "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.bigint "primary_edition_id"
    t.string "language"
    t.string "edition_language"
    t.integer "format"
    t.integer "edition_number"
    t.string "edition_description"
    t.string "edition_title"
    t.string "edition_subtitle"
    t.string "image_url"
    t.string "publisher_url"
    t.string "asin"
    t.string "goodreads_id"
    t.boolean "want_to_read", default: true, null: false
    t.string "tags", default: [], array: true
    t.string "series"
    t.float "series_order"
    t.bigint "owner_id"
    t.boolean "was_borrowed"
    t.string "borrowed_from"
    t.date "acquired_date"
    t.date "alienated_date"
    t.bigint "parent_edition_id"
    t.index ["first_author_id"], name: "index_books_on_first_author_id"
    t.index ["owner_id"], name: "index_books_on_owner_id"
    t.index ["parent_edition_id"], name: "index_books_on_parent_edition_id"
    t.index ["primary_edition_id"], name: "index_books_on_primary_edition_id"
    t.index ["tags"], name: "index_books_on_tags", using: :gin
    t.check_constraint "NOT (primary_edition_id IS NULL AND first_author_id IS NULL)", name: "either_parent_or_author"
    t.check_constraint "primary_edition_id IS NULL OR first_author_id IS NULL", name: "only_parent_or_author"
  end

  create_table "log_entries", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.datetime "progress_date"
    t.integer "progress_page"
    t.float "progress_percentage"
    t.boolean "exclude_from_stats"
    t.boolean "abandoned"
    t.integer "start_precision"
    t.integer "end_precision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_log_entries_on_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authors", "authors", column: "primary_identity_id"
  add_foreign_key "authorships", "authors"
  add_foreign_key "authorships", "books"
  add_foreign_key "books", "authors", column: "first_author_id"
  add_foreign_key "books", "books", column: "parent_edition_id"
  add_foreign_key "books", "books", column: "primary_edition_id"
  add_foreign_key "books", "users", column: "owner_id"
  add_foreign_key "log_entries", "books"
end
