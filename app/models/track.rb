class Track < ActiveRecord::Base
  belongs_to :event

  has_attached_file :image, styles: {thumb: "60x60>"},
    default_url: "/images/:style/missing.png"
  validates_attachment :image, size: { in: 0..10.megabytes },
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"]}

  validates :name, :distance, presence: true
end
