class Entry < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

  belongs_to :user
  belongs_to :journal

  validates :title, :post, :user, :journal, presence: true
end
