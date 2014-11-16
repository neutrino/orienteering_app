class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :nickname
      t.text :details
      t.references :track, index: true

      t.timestamps
    end
  end
end
