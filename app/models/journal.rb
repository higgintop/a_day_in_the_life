class Journal < ActiveRecord::Base
    validates :title, presence: true, uniqueness: {case_sensitive: false}

    default_scope -> {order(:title)}
end
