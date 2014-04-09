class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :inverse_of => :album, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, presence: true
end
