class Api::V1::RaceResultsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament_entry, only: [:index, :create]
    before_action :set_result, only: [:update, :destroy]


    def index
        results = @tournament_entry.race_results
        render json: results
    end

    def create
        result = @tournament_entry.race_results.build(result_params)
        
        if result.save
            render json: result, status: :created
        else
            render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @result.update(result_params)
            render json: @result
        else
            render json: { errors: @result.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @result.destroy
        render json: { message: "削除できました" }
    end

    private

    def result_params
        params.require(:race_result).permit(:race_number, :score)
    end

    def set_tournament_entry
        @tournament_entry = current_user.tournament_entries.find(params[:tournament_entry_id])
    end

    def set_result
        @result = current_user.race_results.find(params[:id])
    end
end
