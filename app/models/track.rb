class Track < ActiveRecord::Base
  belongs_to :event
  validates :name, :distance, presence: true
end
