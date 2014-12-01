class Result < ActiveRecord::Base
  belongs_to :track
  serialize :control_points, Array
end
