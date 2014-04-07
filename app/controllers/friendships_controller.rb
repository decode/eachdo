class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setup_friends, except: :index

  #def index
    #@friendships = current_user.friendships
  #end

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
    redirect_to users_path, notice: "Friend request sent."
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to :back
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to :back
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.name}"
    end
    redirect_to :back 
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} deleted!"
    else
      flash[:notice] = "You aren't friends with #{@friend.name}"
    end
    redirect_to :back
  end

  private
  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

end
