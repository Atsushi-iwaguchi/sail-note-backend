class MonthlyGoal < ApplicationRecord
    belongs_to :user

    validates :goal_date, presence: true
    validates :content, presence: true
end
