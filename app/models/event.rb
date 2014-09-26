class Event < ActiveRecord::Base

  validates :name, :location, :start_date, :end_date, :starting_point, presence: true

end
