class AddVersionToEnvrionment < ActiveRecord::Migration
  def change
    add_column :environments, :version, :string
  end
end
