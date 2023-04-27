class Notification < ApplicationRecord
  belongs_to :user
  enum notice_type: { react: 0, comment: 1}

  default_scope -> { order(created_at: :desc) }
end
