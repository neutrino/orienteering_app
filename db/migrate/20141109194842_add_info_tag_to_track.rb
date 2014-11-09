class AddInfoTagToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :info_tag, :string
  end
end
