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

ActiveRecord::Schema[7.0].define(version: 2024_12_26_035725) do
  create_table "accessories", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "topping_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_accessories_on_item_id"
    t.index ["topping_id"], name: "index_accessories_on_topping_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "name", null: false
    t.integer "discount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "fullname", null: false
    t.string "address", null: false
    t.string "mail"
    t.date "birthed_on"
    t.string "tel"
    t.string "password_digest", null: false
    t.string "password_confirmation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.boolean "admin", null: false
    t.string "name", null: false
    t.string "fullname", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "order_id", null: false
    t.integer "number", null: false
    t.string "size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "price", null: false
    t.string "store", null: false
    t.string "state", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "kinds", null: false
    t.string "name", null: false
    t.integer "price", null: false
    t.boolean "published", null: false
    t.boolean "kids", null: false
    t.boolean "recommend", null: false
    t.string "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requires", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.integer "product_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_requires_on_product_id"
    t.index ["stock_id"], name: "index_requires_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number", null: false
    t.string "assort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "coupon_id", null: false
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_tickets_on_coupon_id"
    t.index ["customer_id"], name: "index_tickets_on_customer_id"
  end

  create_table "toppings", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.string "name", null: false
    t.integer "price", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_toppings_on_stock_id"
  end

end
