class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :picture, PictureUploader

  def url
    picture.url
  end
end
