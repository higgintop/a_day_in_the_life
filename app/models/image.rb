class Image < ActiveRecord::Base
  belongs_to :entries
  mount_uploader :image, AvatarUploader
end

