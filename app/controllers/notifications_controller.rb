class NotificationsController < ApplicationController
  def read
    respond_to do |format|
      if current_user.notifications.where(read: false).update_all(read: true)
        format.turbo_stream
        format.html{
          flash[:success] = "Read notifications!"
          if request.referrer.nil?
            redirect_to root_url
          else
            redirect_to request.referrer
          end     
        }
      else
        redirect_to request.referrer, status: :unprocessable_entity
      end
    end
  end
end
