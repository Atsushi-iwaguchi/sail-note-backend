class Api::V1::TournamentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament, only: [ :show, :destroy, :update ]

    def index
        tournaments = Tournament.order(created_at: :desc)
        render json: tournaments
    end

    def create
        tournament = Tournament.new(tournament_params)

        if tournament.save
            render json: tournament, status: :created
        else
            render json: { errors: tournament.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render json: @tournament
    end

    def destroy
        @tournament.destroy
        render json: { message: "削除しました" }
    end

    def update
        if @tournament.update(tournament_params)
            render json: @tournament
        else
            render json: { errors: @tournament.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def set_tournament
        @tournament = Tournament.find(params[:id])
    end

    def tournament_params
        params.require(:tournament).permit(
            :name,
            :start_date,
            :end_date,
            :boats_count,
            :race_count
        )
    end
end
