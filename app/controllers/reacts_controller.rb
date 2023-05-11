class ReactsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :update]
  # skip_before_action :verify_authenticity_token

  def create
    @react = current_user.reacts.build(react_params)
    respond_to do |format|
      if @react.save
        notification_react
        format.turbo_stream
        format.html{
          flash[:success] = "React created!"
          if request.referrer.nil? || request.referrer == microposts_url
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

  def destroy
    respond_to do |format|
      if @react.destroy
        notification = Notification.find_by notification_with_id: @react.id, notice_type: "react"
        notification.destroy
        format.turbo_stream
        format.html{
          flash[:success] = "React deleted"
          if request.referrer.nil? || request.referrer == microposts_url
            redirect_to root_url
          else
            redirect_to request.referrer
          end      
        }
      end
    end
  end

  def update
    @react = React.find(params[:id])
    respond_to do |format|
      if @react.update(react_params)
        format.turbo_stream
        format.html{
          flash[:success] = "React updated!"
          if request.referrer.nil? || request.referrer == microposts_url
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

  private
    def react_params
      binding.b #test params value (be changed by JS)
      params.require(:react).permit(:emotion, :micropost_id)
    end

    def correct_user
      @react = current_user.reacts.find_by(id: params[:id])
      @micropost = @react.micropost
      redirect_to root_url if @react.nil?
    end

    def notification_react
      post = @react.micropost
      content = "#{current_user.name} đã react tại #{post.content}"
      notification = Notification.create(user_id: post.user_id, notice_type: "react", notification_with_id: @react.id, content: content)
      react_num = post.reacts.count
      notiNotReadNum = Notification.where(user_id: post.user_id, read: false).count
      ActionCable.server.broadcast("notification_channel_#{notification.user_id}", {
        created_at: notification.created_at,
        content: notification.content,
        reactNum: react_num,
        reactPostID: post.id,
        notiNotReadNum: notiNotReadNum,
        href: notification.notification_info
      })
      
      # current_user.send_notification(notification)
    end
end
