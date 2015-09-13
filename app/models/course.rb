class Course < ActiveRecord::Base
  belongs_to :school
  belongs_to :teacher, class_name: "User", foreign_key: "user_id"

  has_many :tasks
  has_many :user_courses
  has_many :students, through: :user_courses, source: :user
end
