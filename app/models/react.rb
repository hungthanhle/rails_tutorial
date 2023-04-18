class React < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true

  enum emotion: { like: 0, love: 1, haha: 2, wow: 3, sad: 4, angry: 5}
end
