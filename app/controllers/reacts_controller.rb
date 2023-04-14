class ReactsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @react = current_user.reacts.build(react_params)
    respond_to do |format|
      if @react.save
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

  private
    def react_params
      params.require(:react).permit(:emotion, :micropost_id)
    end

    def correct_user
      @react = current_user.reacts.find_by(id: params[:id])
      @micropost = @react.micropost
      redirect_to root_url if @react.nil?
    end
end
