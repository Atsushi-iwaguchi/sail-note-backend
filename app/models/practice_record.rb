class PracticeRecord < ApplicationRecord
    belongs_to :user

    has_many :comments, dependent: :destroy
    has_many_attached :images

    validates :practice_date, presence: true

    scope :from_date, ->(date) { date.present? ? where("practice_date >= ?", date) : all }
    scope :to_date, ->(date) { date.present? ? where("practice_date <= ?", date) : all }
    scope :wind_direction, ->(direction) { direction.present? ? where(wind_direction: direction) : all }
    scope :min_wind, ->(speed) { speed.present? ? where("max_wind_speed >= ?", speed) : all }
    scope :max_wind, ->(speed) { speed.present? ? where("min_wind_speed <= ?", speed) : all }

    enum :tide, {
        oshio: 0,
        nakashio: 1,
        koshio: 2,
        nagashio: 3,
        wakashio: 4
    }
end
