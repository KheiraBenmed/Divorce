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

ActiveRecord::Schema.define(version: 20170608082603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avocats", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "phone_number"
    t.string "email"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "avocat_id"
    t.bigint "procedure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avocat_id"], name: "index_contacts_on_avocat_id"
    t.index ["procedure_id"], name: "index_contacts_on_procedure_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.integer "child_nb"
    t.integer "owner_nb"
    t.integer "renter_nb"
    t.string "status_pro"
    t.integer "bank_account_nb"
    t.integer "credit_nb"
    t.integer "insurance_nb"
    t.integer "vehicle_nb"
    t.string "contract_type"
    t.string "status_pro_conjoint"
    t.boolean "marriage_contract"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "passport"
    t.string "passport_spouse"
    t.string "passport_children"
    t.string "identity"
    t.string "identity_spouse"
    t.string "identity_children"
    t.string "acte_naissance"
    t.string "acte_naissance_spouse"
    t.string "acte_naissance_children"
    t.string "livret"
    t.string "acte_mariage"
    t.string "contract_mariage"
    t.string "taxe_habitation"
    t.string "taxe_fonciere"
    t.string "rent"
    t.string "bills"
    t.string "insurance_vehicle"
    t.string "life_insurance"
    t.string "insurance_other"
    t.string "scolarite"
    t.string "caf"
    t.string "payroll"
    t.string "payroll_spouse"
    t.string "payroll_dec"
    t.string "payroll_spouse_dec"
    t.string "bilan_company"
    t.string "unemployment"
    t.string "unemployment_spouse"
    t.string "pro_revenu"
    t.string "pro_revenu_spouse"
    t.string "taxes"
    t.string "taxes_spouse"
    t.string "property"
    t.string "revenu_foncier"
    t.string "bank_account"
    t.string "carte_grise"
    t.string "archive"
    t.index ["user_id"], name: "index_procedures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "avocats"
  add_foreign_key "contacts", "procedures"
  add_foreign_key "contacts", "users"
  add_foreign_key "procedures", "users"
end
