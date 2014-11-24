json.extract! @track, :id, :distance, :name, :event, :image, :info_tag, :control_points, :created_at, :updated_at
json.image_url image_url(@track.image)