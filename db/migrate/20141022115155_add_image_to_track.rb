class AddImageToTrack < ActiveRecord::Migration
  def change
    add_attachment :tracks, :image
  end
end
