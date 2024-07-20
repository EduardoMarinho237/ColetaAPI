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

ActiveRecord::Schema[7.1].define(version: 2024_07_20_193333) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.bigint "formulary_id", null: false
    t.bigint "question_id", null: false
    t.bigint "visit_id", null: false
    t.datetime "answered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_answers_on_deleted_at"
    t.index ["formulary_id"], name: "index_answers_on_formulary_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["visit_id"], name: "index_answers_on_visit_id"
  end

  create_table "formularies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_formularies_on_deleted_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.bigint "formulary_id", null: false
    t.string "question_type", default: "texto", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_questions_on_deleted_at"
    t.index ["formulary_id"], name: "index_questions_on_formulary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

  create_table "visits", force: :cascade do |t|
    t.date "date"
    t.string "status", default: "pendente", null: false
    t.bigint "user_id", null: false
    t.datetime "checkin_at"
    t.datetime "checkout_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["deleted_at"], name: "index_visits_on_deleted_at"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "answers", "formularies"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "visits"
  add_foreign_key "questions", "formularies"
  add_foreign_key "visits", "users"
end
