class Entry < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  extend SimpleCalendar
  has_calendar  :attribute => :created_at
  belongs_to :user
  belongs_to :journal

  validates :title, :post, :user, :journal, presence: true
end
