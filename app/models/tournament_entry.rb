class TournamentEntry < ApplicationRecord
    belongs_to :user
    belongs_to :tournament

    has_many :race_results, -> { order(:race_number) }, dependent: :destroy

    validates :overall_ranking, presence: true
    validates :user_id, uniqueness: { scope: :tournament_id }
end
