class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :correct_user, only: :destroy
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      if !@micropost.micropost_id.nil?
        post = Micropost.find_by id: @micropost.micropost_id, micropost_id: nil
        notification = Notification.create(user_id: post.user_id, notice_type: "comment", notification_with_id: @micropost.id)
        ActionCable.server.broadcast("notification_channel_#{notification.user_id}", "#{current_user.name} đã comment tại post #{post.content}")
      end
      flash[:success] = "Micropost created!"
      if request.referrer.nil? || request.referrer == microposts_url
        redirect_to root_url
      else
        redirect_to request.referrer
      end
    else
      @feed_items = current_user.feed_post.paginate(page: params[:page], per_page: params[:per_page] || 4)
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    if !@micropost.micropost_id.nil?
      notification = Notification.find_by notification_with_id: @micropost.id, notice_type: "comment"
      notification.destroy
    end
    flash[:success] = "Micropost deleted"
    if request.referrer.nil? || request.referrer == microposts_url || request.referer == request.original_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  def show
    @micropost = Micropost.find_by id: params[:id], micropost_id: nil
    @user = User.find(@micropost.user_id) #
    @comments = Micropost.where(micropost_id: params[:id]).page(params[:page]).per_page(params[:per_page] || 4)
    @react = React.find_by micropost_id: params[:id], user_id: current_user.id
    @comment = Micropost.new
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image, :micropost_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
