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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141201032841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "local_id"
    t.integer  "user_id"
    t.integer  "yearstart"
    t.integer  "monthstart"
    t.integer  "daystart"
    t.integer  "yeardue"
    t.integer  "monthdue"
    t.integer  "daydue"
    t.integer  "opentasks"
    t.integer  "totaltasks"
    t.string   "coverpath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "local_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "priority"
    t.integer  "percentage"
    t.integer  "yearstart"
    t.integer  "monthstart"
    t.integer  "daystart"
    t.integer  "yeardue"
    t.integer  "monthdue"
    t.integer  "daydue"
    t.string   "photopath"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nombre"
    t.string   "password"
    t.string   "email"
    t.string   "auth_token"
    t.integer  "request_pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
