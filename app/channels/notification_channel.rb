class NotificationChannel < ApplicationCable::Channel
  def subscribed
    notication_user_id = params[:notication_user_id] || current_user.id
    stream_from "notification_channel_#{notication_user_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
