class Team < ActiveRecord::Base
  has_many :members, class_name: 'User'
  belongs_to :school
end
