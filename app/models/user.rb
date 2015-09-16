class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :rememberable, :trackable, #:validatable, :recoverable, :invitable, 
         :omniauthable, omniauth_providers: [:weibo, :tqq]

  mount_uploader :avatar, AvatarUploader

  has_many :authentications

  acts_as_messageable

  validates :name,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  attr_accessor :login

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

  has_many :courses
  has_many :user_courses, :dependent => :delete_all
  has_many :study_courses, :through => :user_courses, :source => :course, :dependent => :delete_all
  has_many :tasks

  has_many :task_scores, :dependent => :delete_all
  has_many :scored_tasks, through: :task_scores, source: :task, :dependent => :delete_all

  belongs_to :team
  belongs_to :school

  before_create :append_roles

  def append_roles
    self.roles << Role.where(name: 'student').first
    self.roles << Role.where(name: 'user').first
  end

  def good_rates
    return "0%" if received_feedbacks.length == 0
    good = received_feedbacks.where judgement: '好评'
    return (good.length/feedbacks.length*100).to_s + "%"
  end

  def forem_name
    name
  end

  def join_team(team)
    self.team = team
    self.save
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["name = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end
end
