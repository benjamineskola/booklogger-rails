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

ActiveRecord::Schema[7.0].define(version: 2022_11_19_112823) do
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
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.integer "first_author_id", null: false
    t.string "first_author_role"
    t.integer "first_published", limit: 2
    t.integer "edition_published", limit: 2
    t.string "publisher"
    t.integer "page_count", limit: 2
    t.string "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_author_id"], name: "index_books_on_first_author_id"
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer "book_id", null: false
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

  add_foreign_key "books", "authors", column: "first_author_id"
  add_foreign_key "log_entries", "books"
end
