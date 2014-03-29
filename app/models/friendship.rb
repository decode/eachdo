class Friendship < ActiveRecord::Base
  belongs_to :user

  def friend
    User.find self.friend_id
  end
end
