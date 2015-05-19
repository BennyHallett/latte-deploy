class CreateReleaseActivities < ActiveRecord::Migration
  def change
    create_table :release_activities do |t|
      t.string :outcome
      t.datetime :release_date
      t.text :log, limit: 2048

      t.belongs_to :release, index: true
      t.belongs_to :environment, index: true

      t.timestamps null: false
    end
  end
end
