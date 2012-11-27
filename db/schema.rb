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

ActiveRecord::Schema.define(:version => 20121126031605) do

  create_table "group_parameters", :force => true do |t|
    t.integer  "group_id"
    t.string   "parameter_id"
    t.integer  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "group_values", :force => true do |t|
    t.integer  "group_id"
    t.integer  "value_id"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "limit_pairs", :force => true do |t|
    t.integer  "matrix_config_id"
    t.integer  "first_value_id"
    t.integer  "second_value_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "matrix_configs", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.integer  "version_id"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "has_results"
  end

  create_table "matrix_params", :force => true do |t|
    t.integer  "matrix_config_id"
    t.integer  "parameter_id"
    t.integer  "status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "matrix_values", :force => true do |t|
    t.integer  "matrix_param_id"
    t.integer  "value_id"
    t.decimal  "weight",          :precision => 10, :scale => 4
    t.boolean  "is_chosen"
    t.integer  "status"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "parameters", :force => true do |t|
    t.string   "name"
    t.float    "weight"
    t.boolean  "is_default"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "results", :force => true do |t|
    t.integer  "matrix_param_id"
    t.integer  "value_id"
    t.boolean  "has_chosen"
    t.integer  "sort_id"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.integer  "matrix_config_id"
    t.integer  "tag",                                             :default => 0
    t.decimal  "sumWeight",        :precision => 10, :scale => 4
    t.decimal  "pairWeight",       :precision => 10, :scale => 4
    t.decimal  "coverage",         :precision => 10, :scale => 4
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "values", :force => true do |t|
    t.string   "value"
    t.float    "weight"
    t.integer  "parameter_id"
    t.boolean  "is_default"
    t.integer  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "values", ["parameter_id"], :name => "index_values_on_parameter_id"

end
