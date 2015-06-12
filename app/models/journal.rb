class Journal < ActiveRecord::Base
    has_many :entries
    belongs_to :users
 
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :user_id, presence: true 

    default_scope -> {order(:title)}
end
