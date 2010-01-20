class CreateGrantLevelsTable < ActiveRecord::Migration
  def self.up
    create_table UserSystem::GrantLevel.table_name do |t|
      t.string :name
    end
    add_index UserSystem::GrantLevel.table_name, [:name]
  end

  def self.down
    drop_table UserSystem::GrantLevel.table_name
  end
end
