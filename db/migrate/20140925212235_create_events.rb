class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.string :terrain
      t.date :start_date
      t.date :end_date
      t.text :starting_point

      t.timestamps
    end
  end
end
