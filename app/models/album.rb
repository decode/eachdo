class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :inverse_of => :album, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  belongs_to :house

  validates :title, presence: true

  def can_upload_photo?
    return self.photos.length < 10
  end
end
