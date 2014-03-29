class FriendshipsController < InheritedResources::Base
  before_filter :authenticate_user!

  # Todo
  def new
    user = User.find params[:id]
    unless current_user.is_friend? user
      current_user.add_friend user
    end
  end

  def index
    @frinends = current_user.friends
    @friendships = current_user.friendships
  end

  def add_friend
    user = User.find params[:id]
    unless current_user.has_friend? user
      current_user.add_friend user
    end
    return friendships_path
  end
end
