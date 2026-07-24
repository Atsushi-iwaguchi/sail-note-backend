class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :practice_record

    validates :content, presence: true
end
