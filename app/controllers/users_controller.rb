require 'zip'

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #view middleware
  before_action :correct_user, only: [:edit, :update] #middleware
  before_action :admin_user, only: :destroy #middleware
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.my_post.paginate(page: params[:page], per_page: params[:per_page] || 4)
    @comment = Micropost.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email # = UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    # redirect_to(root_url) unless @user == current_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def bulk_download
    my_month_post = current_user.my_post.where(:created_at => 1.month.ago..Time.now)
    my_month_following = current_user.my_following_and_time(:created_at => 1.month.ago..Time.now)
    my_month_followers = current_user.my_followers_and_time(:created_at => 1.month.ago..Time.now)
    respond_to do |format|
      format.zip {
        compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          csv = ExportCsvService.new my_month_post, %w(content created_at).freeze
          zos.put_next_entry "#{current_user.name}_month_post.csv"
          zos.print csv.perform_object

          csv = ExportCsvService.new my_month_following, %w(name created_at_vn).freeze
          zos.put_next_entry "#{current_user.name}_month_following.csv"
          zos.print csv.perform_array

          csv = ExportCsvService.new my_month_followers, %w(name created_at_vn).freeze
          zos.put_next_entry "#{current_user.name}_month_followers.csv"
          zos.print csv.perform_array
        end
        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "#{current_user.name}.zip"
      }
    end
    
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
