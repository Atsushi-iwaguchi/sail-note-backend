class Api::V1::TournamentEntriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament, only: [:index, :create]
    before_action :set_entry, only: [:destroy, :update]

    def index
        entries = @tournament.tournament_entries
        render json: entries
    end

    def create
        entry = current_user.tournament_entries.new(
            #belongs_to :tournament の関連付けを利用
            tournament: @tournament,
            overall_ranking: entry_params[:overall_ranking],
            reflection: entry_params[:reflection]
        )

        if entry.save
            render json: entry, status: :created
        else
            render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @entry.update(entry_params)
            render json: @entry
        else
            render json: { errors: @entry.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @entry.destroy
        render json: { message: "削除しました" }
    end

    private

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
    end

    def set_entry
        @entry = current_user.tournament_entries.find(params[:id])
    end

    def entry_params
        params.require(:tournament_entry).permit(:overall_ranking, :reflection)
    end
end
