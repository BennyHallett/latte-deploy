class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :uri
      t.string :path

      t.belongs_to :project

      t.timestamps null: false
    end

    add_index :repos, :name
  end
end
