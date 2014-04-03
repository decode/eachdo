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
  has_many :friends,
    -> { where(friendships: {status: 'accepted'}).order(:name)},
    through: :friendships
  has_many :requested_friends,
    -> { where(friendships: {status: 'requested'}).order(:created_at)},
    through: :friendships,
    source: :friend
  has_many :pending_friends,
    -> { where(friendships: {status: 'pending'}).order(:created_at)},
    through: :friendships,
    source: :friend

  #has_and_belongs_to_many :friends,
    #after_add: :create_complement_friendship,
    #after_remove: :remove_complement_friendship

  #private
  #def create_complement_friendship(friend)
    #friend.friends << self unless friend.friends.include?(self)
  #end

  #def remove_complement_friendship(friend)
    #friend.friends.delete(self)
  #end

end
