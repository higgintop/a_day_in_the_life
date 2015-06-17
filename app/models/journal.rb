class Journal < ActiveRecord::Base
    has_many :entries
    belongs_to :user

    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :user, presence: true

    default_scope -> {order(:title)}
end
