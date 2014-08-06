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

  has_one :information
  has_many :albums
  has_many :houses
  has_many :orders

  has_many :trades, source: :orders, through: :houses
  has_many :feedbacks
  has_many :received_feedbacks, source: :feedback, through: :orders

  def good_rates
    return "0%" if received_feedbacks.length == 0
    good = received_feedbacks.where judgement: '好评'
    return (good.length/feedbacks.length*100).to_s + "%"
  end
end
