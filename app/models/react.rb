class React < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true

  EMOTION_OPTIONS = %w(like love haha wow sad angry)
  validates :emotion, :inclusion => {:in => EMOTION_OPTIONS}
end
