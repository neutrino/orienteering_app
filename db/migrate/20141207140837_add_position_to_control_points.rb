class AddPositionToControlPoints < ActiveRecord::Migration
  def change
    add_column :control_points, :position, :integer
  end
end
