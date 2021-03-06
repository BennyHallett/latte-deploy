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

ActiveRecord::Schema.define(version: 20150517220925) do

  create_table "environments", force: :cascade do |t|
    t.string   "name"
    t.integer  "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "version"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "key"
  end

  add_index "projects", ["key"], name: "index_projects_on_key"
  add_index "projects", ["name"], name: "index_projects_on_name"

  create_table "release_activities", force: :cascade do |t|
    t.string   "outcome"
    t.datetime "release_date"
    t.text     "log",            limit: 2048
    t.integer  "release_id"
    t.integer  "environment_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "release_activities", ["environment_id"], name: "index_release_activities_on_environment_id"
  add_index "release_activities", ["release_id"], name: "index_release_activities_on_release_id"

  create_table "releases", force: :cascade do |t|
    t.string   "name"
    t.integer  "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repos", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.string   "path"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "key"
  end

  add_index "repos", ["key"], name: "index_repos_on_key"
  add_index "repos", ["name"], name: "index_repos_on_name"

end
