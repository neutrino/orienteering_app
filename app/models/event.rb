class Event < ActiveRecord::Base

  has_many :tracks
  validates :name, :location, :start_date, :end_date, :starting_point, presence: true

end
