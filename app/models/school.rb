class School < ActiveRecord::Base
  has_many :teams
  has_many :users
  has_many :courses
end
