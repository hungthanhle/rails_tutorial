class Micropost < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  default_scope -> { order(created_at: :desc) } #order('created_at DESC')
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
      size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  has_many :reacts, dependent: :destroy
  # Returns a resized image for display.
  # def display_image
  #   image.variant(resize_to_limit: [700, 200])
  # end
end
