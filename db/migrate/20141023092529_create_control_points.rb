class CreateControlPoints < ActiveRecord::Migration
  def change
    create_table :control_points do |t|
      t.string :tag_id
      t.references :track, index: true

      t.timestamps
    end
  end
end
