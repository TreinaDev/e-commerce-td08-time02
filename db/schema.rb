s# This file is auto-generated from the current state of the database. Instead
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

ActiveRecord::Schema[7.0].define(version: 2022_06_21_202121) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id", null: false
    t.integer "status", default: 1
    t.integer "promotion_id"
    t.index ["admin_id"], name: "index_categories_on_admin_id"
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["name", "category_id"], name: "index_categories_on_name_and_category_id", unique: true
    t.index ["promotion_id"], name: "index_categories_on_promotion_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "product_id", null: false
    t.decimal "value"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_prices_on_admin_id"
    t.index ["product_id"], name: "index_prices_on_product_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id", null: false
    t.integer "purchase_id"
    t.index ["client_id"], name: "index_product_items_on_client_id"
    t.index ["product_id"], name: "index_product_items_on_product_id"
    t.index ["purchase_id"], name: "index_product_items_on_purchase_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "description"
    t.string "sku"
    t.decimal "width"
    t.decimal "height"
    t.decimal "depth"
    t.decimal "weight"
    t.decimal "shipping_price"
    t.boolean "fragile", default: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

<<<<<<< HEAD
  create_table "purchases", force: :cascade do |t|
    t.integer "client_id", null: false
    t.decimal "value"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_purchases_on_client_id"
=======
  create_table "promotions", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "name"
    t.integer "discount_percentual"
    t.decimal "discount_max"
    t.integer "used_times", default: 0
    t.string "coupon"
    t.integer "usage_limit"
    t.integer "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_promotions_on_admin_id"
>>>>>>> 55991fe0d3fdca5fe1b054c284990d68e016f849
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "admins"
  add_foreign_key "categories", "categories"
  add_foreign_key "categories", "promotions"
  add_foreign_key "prices", "admins"
  add_foreign_key "prices", "products"
  add_foreign_key "product_items", "clients"
  add_foreign_key "product_items", "products"
  add_foreign_key "product_items", "purchases"
  add_foreign_key "products", "categories"
<<<<<<< HEAD
  add_foreign_key "purchases", "clients"
=======
  add_foreign_key "promotions", "admins"
>>>>>>> 55991fe0d3fdca5fe1b054c284990d68e016f849
end
