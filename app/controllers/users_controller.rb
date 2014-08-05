class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:show]

  def index
    #authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    case session[:friend_type]
    when 'pending_friend' then
      @friends = @user.pending_friends.paginate page: params[:page]
    when 'decline_friend' then
      @friends = @user.requested_friends.paginate page: params[:page]
    else
      @friends = @user.friends.paginate page: params[:page]
    end
  end
  
  def update
    #authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    #authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
