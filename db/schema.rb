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

ActiveRecord::Schema.define(version: 20191101024740) do

  create_table "bookings", force: :cascade do |t|
    t.string   "name"
    t.integer  "phone"
    t.integer  "status",     default: 0
    t.float    "price"
    t.datetime "date_in"
    t.datetime "date_out"
    t.integer  "user_id"
    t.integer  "tour_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["tour_id", "created_at"], name: "index_bookings_on_tour_id_and_created_at"
    t.index ["tour_id"], name: "index_bookings_on_tour_id"
    t.index ["user_id", "created_at"], name: "index_bookings_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "comment_id"
    t.string   "comment_type"
    t.string   "content"
    t.integer  "parent_id",    default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id", "review_id"], name: "index_likes_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tour_id"
    t.integer  "rating_value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["tour_id", "updated_at"], name: "index_ratings_on_tour_id_and_updated_at"
    t.index ["tour_id"], name: "index_ratings_on_tour_id"
    t.index ["user_id", "updated_at"], name: "index_ratings_on_user_id_and_updated_at"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "content"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_reviews_on_category_id"
    t.index ["user_id", "updated_at"], name: "index_reviews_on_user_id_and_updated_at"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "content"
    t.string   "image"
    t.float    "price"
    t.datetime "date_in"
    t.datetime "date_out"
    t.integer  "rating",      default: 0
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["rating"], name: "index_tours_on_rating"
    t.index ["title", "created_at"], name: "index_tours_on_title_and_created_at"
    t.index ["user_id"], name: "index_tours_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role",            default: 1
    t.boolean  "gender",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
