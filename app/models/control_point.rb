class ControlPoint < ActiveRecord::Base
  belongs_to :track
  validates :tag_id, presence: true
  validates_uniqueness_of :tag_id, scope: :track
end
