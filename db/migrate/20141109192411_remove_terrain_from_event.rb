class RemoveTerrainFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :terrain
  end

  def down
    add_column :events, :terrain, :string
  end
end