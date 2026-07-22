class PracticeRecord < ApplicationRecord
    belongs_to :user

    has_many :comments, dependent: :destroy

    validates :practice_date, presence: true

    enum :tide, {
        oshio: 0,
        nakashio: 1,
        koshio: 2,
        nagashio: 3,
        wakashio: 4
    }
end
