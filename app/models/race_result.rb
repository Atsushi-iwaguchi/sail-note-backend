class RaceResult < ApplicationRecord
    belongs_to :tournament_entry

    validates :race_number, uniqueness: { scope: :tournament_entry_id }
end
