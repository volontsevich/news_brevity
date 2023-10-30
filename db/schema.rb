ActiveRecord::Schema[7.0].define(version: 2023_10_30_030732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "summaries", force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
