class Notification < ApplicationRecord
  belongs_to :user
  enum notice_type: { react: 0, comment: 1}

  default_scope -> { order(created_at: :desc) }

  def notification_info
    if notice_type == "react"
      react = React.find(notification_with_id)
      if react.micropost.micropost_id.nil?
        #post
        return "/microposts/#{react.micropost.id}"
      else
        #comment
        position = Micropost.where("micropost_id = ? AND created_at >= ?", react.micropost.micropost_id, react.micropost.created_at).count
        return "/microposts/#{react.micropost.micropost_id}?page=#{position}&per_page=1"
      end
    end

    if notice_type == "comment"
      comment = Micropost.find(notification_with_id)
      if !comment.micropost_id.nil?
        #comment
        position = Micropost.where("micropost_id = ? AND created_at >= ?", comment.micropost_id, comment.created_at).count
        return "/microposts/#{comment.micropost_id}?page=#{position}&per_page=1"
      end
    end
  end
end
