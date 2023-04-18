class React < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true

  enum :emotion, [:like, :love, :haha, :wow, :sad, :angry]
end
