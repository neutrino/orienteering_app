class Event < ActiveRecord::Base

  has_many :tracks
  validates :name, :location, :start_date, :end_date, :starting_point, presence: true

  scope :active, -> { where("? BETWEEN start_date AND end_date", Date.today) }

end
