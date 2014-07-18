class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  mount_uploader :avatar, AvatarUploader

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

  has_many :albums
  has_one :information
  has_many :houses
  has_many :orders

end
