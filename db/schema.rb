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

ActiveRecord::Schema[7.2].define(version: 2025_08_06_184501) do
  create_table "books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.integer "stock", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_books_on_deleted_at"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
  end

  create_table "borrowers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "id_card_number"
    t.string "name"
    t.string "email"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_borrowers_on_deleted_at"
    t.index ["email"], name: "index_borrowers_on_email"
    t.index ["id_card_number"], name: "index_borrowers_on_id_card_number"
  end

  create_table "loans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "borrower_id"
    t.datetime "due_date"
    t.datetime "returned_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["borrower_id"], name: "index_loans_on_borrower_id"
    t.index ["deleted_at"], name: "index_loans_on_deleted_at"
  end

  add_foreign_key "loans", "books"
  add_foreign_key "loans", "borrowers"
end
