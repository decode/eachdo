class Photo < ActiveRecord::Base
  belongs_to :album
  validates :album, :image, presence: true

  mount_uploader :image, PhotoUploader
  include Rails.application.routes.url_helpers

  def to_fileupload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => photo_path(self),
      "delete_type" => "DELETE"
    }
  end

end
