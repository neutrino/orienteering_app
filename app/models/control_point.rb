class ControlPoint < ActiveRecord::Base
  belongs_to :track

  default_scope { order('position ASC')}
  acts_as_list scope: :track

  validates :tag_id, presence: true
  validates_uniqueness_of :tag_id, scope: :track
end
