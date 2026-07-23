class Tournament < ApplicationRecord
    has_many :tournament_entries
    validates :name, presence: true
end
