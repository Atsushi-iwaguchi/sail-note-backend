class TournamentEntry < ApplicationRecord
    belongs_to :user
    belongs_to :tournament

    validates :overall_ranking, presence: true
    validates :user_id, uniqueness: { scope: :tournament_id }
end
