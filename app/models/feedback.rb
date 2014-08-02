class Feedback < ActiveRecord::Base
  belongs_to :house
  belongs_to :order
  belongs_to :user

  validate :title, :comment, :rating, presence: true
end
