class PracticeRecord < ApplicationRecord
    belongs_to :user

    has_many :comments, dependent: :destroy
    has_many_attached :images

    validates :practice_date, presence: true

    scope :from_date, ->(date) { where("practice_date >=? date") if date.present? }
    scope :to_date, ->(date) { where("practice_date <=? date") if date.present? }
    scope :wind_direction, ->(direction) { where(wind_direction: direction) if direction.present? }
    scope :max_wind, ->(speed) { where("max_wind_speed <= speed") if speed.present? }
    scope :min_wind, ->(speed) { where("min_wind_speed >= speed") if speed.present? }

    enum :tide, {
        oshio: 0,
        nakashio: 1,
        koshio: 2,
        nagashio: 3,
        wakashio: 4
    }
end
