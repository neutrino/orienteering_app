class Event < ActiveRecord::Base

  has_many :tracks, dependent: :destroy
  validates :name, :location, :start_date, :end_date, :starting_point, presence: true

  scope :active, -> { where("? BETWEEN start_date AND end_date", Date.today) }

  def active?
    self.start_date < Time.now and self.end_date > Time.now
  end

end
