class Task < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :task_scores, :dependent => :delete_all

  def close?
    return self.status == 'close'
  end
end
