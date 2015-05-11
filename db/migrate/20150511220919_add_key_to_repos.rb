class AddKeyToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :key, :string
    add_index :repos, :key
  end
end
