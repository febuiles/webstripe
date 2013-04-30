# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130430153404) do

  create_table "allies", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "contact_name"
    t.string   "identification"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "email"
    t.string   "user_type"
  end

  create_table "attachments", :force => true do |t|
    t.text     "title"
    t.string   "attachment"
    t.integer  "file_id"
    t.string   "file_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "close_requests", :force => true do |t|
    t.string   "reason"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "featured_lawyers", :force => true do |t|
    t.text     "body"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "firm_assistants", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "type"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "firm_requests", :force => true do |t|
    t.integer "firm_id"
    t.integer "request_id"
  end

  create_table "firms", :force => true do |t|
    t.string   "name"
    t.string   "nit"
    t.string   "phone"
    t.string   "fax"
    t.string   "address"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "head_count"
    t.boolean  "indie"
  end

  create_table "foundation_control_entries", :force => true do |t|
    t.boolean  "knows_lawyer"
    t.boolean  "received_commitment_letter"
    t.boolean  "talked_to_lawyer"
    t.boolean  "met_lawyer"
    t.boolean  "lawyer_helped"
    t.boolean  "same_situation"
    t.integer  "satisfaction"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "observations"
    t.boolean  "contacted_client"
  end

  create_table "header_images", :force => true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "image"
    t.boolean  "featured_lawyer"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "lawyer_control_entries", :force => true do |t|
    t.integer  "request_id"
    t.boolean  "contacted_client"
    t.boolean  "client_collaborated"
    t.text     "advances"
    t.text     "observations"
    t.string   "commitment_letter"
    t.string   "lawyer_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time_dedicated"
    t.string   "termination_letter"
  end

  create_table "lawyers", :force => true do |t|
    t.string   "name"
    t.string   "cc"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legal_requests", :force => true do |t|
    t.string   "name"
    t.string   "nit"
    t.string   "representative"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "locality"
    t.string   "recommended_by"
    t.string   "contact_name"
    t.string   "contact_position"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "commerce_attachment"
    t.string   "payroll_attachment"
    t.string   "income_attachment"
    t.string   "financial_attachment"
    t.string   "cell_phone"
    t.string   "municipality"
    t.text     "notes"
    t.time     "deleted_at"
  end

  create_table "notices", :force => true do |t|
    t.text     "reason"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notice_type"
    t.string   "redirected_to"
  end

  create_table "personal_requests", :force => true do |t|
    t.string   "name"
    t.string   "cc"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "locality"
    t.integer  "num_children"
    t.integer  "dependent_persons"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "house_is"
    t.string   "recommended_by"
    t.boolean  "works"
    t.string   "type_of_worker"
    t.string   "monthly_income"
    t.string   "income_source"
    t.string   "health_provider"
    t.integer  "sisben_level"
    t.string   "contributed_to_retirement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cell_phone"
    t.string   "municipality"
    t.boolean  "community"
    t.text     "notes"
    t.time     "deleted_at"
  end

  create_table "request_facts", :force => true do |t|
    t.text     "why"
    t.boolean  "had_lawyer"
    t.string   "lawyer_name"
    t.string   "lawyer_phone"
    t.text     "lawyer_progress"
    t.integer  "fact_id"
    t.string   "fact_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "problem"
    t.time     "deleted_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "request_id"
    t.string   "request_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",             :default => "new_requests"
    t.integer  "firm_id"
    t.string   "desist_reason"
    t.string   "law_branch"
    t.string   "action_line"
    t.string   "vulnerability"
    t.string   "type_of_assistance"
    t.integer  "duplicate_of"
    t.integer  "lawyer_id"
    t.integer  "old_system_id"
    t.integer  "deleted_by"
    t.time     "deleted_at"
  end

  create_table "search_indices", :force => true do |t|
    t.integer "record_id"
    t.string  "record_type"
    t.text    "body"
  end

  create_table "stripe_items", :force => true do |t|
    t.string   "item_type"
    t.integer  "stripe_id"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "stripes", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.text     "alignment"
    t.string   "company",         :default => ""
    t.string   "company_url",     :default => ""
    t.string   "page_bg_color",   :default => "e9e5ca"
    t.string   "stripe_bg_color", :default => "050011"
    t.string   "fg_color",        :default => "db0909"
    t.boolean  "premium",         :default => false
    t.string   "company_logo"
    t.string   "text_color",      :default => "e9e5ca"
    t.string   "state"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",      :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "username"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "role",                                 :default => "basic"
    t.string   "status"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
