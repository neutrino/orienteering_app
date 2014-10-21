class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :distance
      t.string :name
      t.references :event

      t.timestamps
    end
  end
end
