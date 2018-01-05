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

ActiveRecord::Schema.define(version: 20180105161531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gardening_pictures", force: :cascade do |t|
    t.bigint "gardening_id"
    t.bigint "picture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gardening_id"], name: "index_gardening_pictures_on_gardening_id"
    t.index ["picture_id"], name: "index_gardening_pictures_on_picture_id"
  end

  create_table "gardening_tags", force: :cascade do |t|
    t.bigint "gardening_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gardening_id", "tag_id"], name: "index_gardening_tags_on_gardening_id_and_tag_id", unique: true
    t.index ["gardening_id"], name: "index_gardening_tags_on_gardening_id"
    t.index ["tag_id"], name: "index_gardening_tags_on_tag_id"
  end

  create_table "gardenings", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "mime_type"
    t.binary "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "small"
    t.binary "thumbnail"
  end

  create_table "recipe_pictures", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "picture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_recipe_pictures_on_picture_id"
    t.index ["recipe_id"], name: "index_recipe_pictures_on_recipe_id"
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipe_tags_on_recipe_id_and_tag_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published"
    t.text "ingredients"
    t.text "preparation"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag"], name: "index_tags_on_tag", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

end
