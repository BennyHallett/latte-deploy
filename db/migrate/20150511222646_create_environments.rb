class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name

      t.belongs_to :repo

      t.timestamps null: false
    end
  end
end
