class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setup_friends, except: [:index, :filter]

  def filter
    session[:friend_type] = params[:id]
    redirect_to current_user
  end

  def index
    @friendships = current_user.friendships
  end

  # Send a friend request.
  def request_friend
    @friend = User.find params[:id]
    Friendship.request(current_user, @friend)
    #UserMailer.deliver_friend_request(
      #:user => @user,
      #:friend => @friend,
      #:user_url => profile_for(@user),
      #:accept_url => url_for(:action => "accept", :id => @user.name),
      #:decline_url => url_for(:action => "decline", :id => @user.name)
    #)
    redirect_to user_path(@friend), notice: t(:send_friend_request_success)
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = t :friend_request_accepted, user: @friend.name
    else
      flash[:notice] = t :request_failed
    end
    redirect_to :back
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t :friend_request_declined, user: @friend.name
    else
      flash[:notice] = t :request_failed
    end
    redirect_to :back
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t :friend_request_canceled, user: @friend.name
    else
      flash[:notice] = t :request_failed
    end
    redirect_to :back 
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t :friend_request_deleted, user: @friend.name
    else
      flash[:notice] = t :not_friend_with, user: @friend.name
    end
    redirect_to :back
  end

  private
  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

end
