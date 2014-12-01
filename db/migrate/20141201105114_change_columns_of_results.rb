class ChangeColumnsOfResults < ActiveRecord::Migration
   def up
    remove_column :results, :details
    add_column :results, :total_time, :string
    add_column :results, :complete, :boolean
    add_column :results, :control_points, :text
  end

  def down
    remove_column :results, :control_points
    remove_column :results, :complete
    remove_column :results, :total_time
    add_column :results, :details, :text
  end
end


