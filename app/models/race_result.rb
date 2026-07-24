class RaceResult < ApplicationRecord
    belongs_to :tournament_entry

    validates :race_number, uniqueness: true
end
