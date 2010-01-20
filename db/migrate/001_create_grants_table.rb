class CreateGrantsTable < ActiveRecord::Migration
  def self.up
    create_table UserSystem::Grant.table_name do |t|
      t.string :grant_object_type
      t.integer :grant_object_id

      t.integer :grant_level_id

      t.integer :user_id, :granting_user_id

      t.timestamp :expires_at
    end

    add_index UserSystem::Grant.table_name, [:grant_object_type, :grant_object_id, :grant_level_id]
    add_index UserSystem::Grant.table_name, [:user_id, :grant_object_type, :grant_level_id]
  end

  def self.down
    drop_table UserSystem::Grant.table_name
  end
end
