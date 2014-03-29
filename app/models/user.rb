class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  has_many :authentications

  acts_as_messageable

  validates :name, presence: true

  has_many :friendships
  has_many :friends, :through => :friendships, :source => :user

  # Todo
  def has_friend?(user)
    friends = Friendship.where("user_id=? and friend_id=?", self.id, user.id)
    return friends.length > 0
  end

  def add_friend(user)
    Friendship.find_or_create_by(user_id: self.id, friend_id: user.id)
  end

  def mutual_friend
  end
end
