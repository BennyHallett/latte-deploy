class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :uri

      t.belongs_to :project

      t.timestamps null: false
    end
  end
end
