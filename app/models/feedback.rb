class Feedback < ActiveRecord::Base
  belongs_to :house
  belongs_to :order
  belongs_to :user

  validates_presence_of :title, :comment, :rating
end
