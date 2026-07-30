class Api::V1::MonthlyGoalsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_goal, only: [ :show, :update, :destroy ]

    def index
        goals = current_user.monthly_goals.order(goal_date: :desc)
        render json: goals
    end

    def show
        render json: @goal
    end

    def create
        goal = current_user.monthly_goals.build(goal_params)
        if goal.save
            render json: goal, status: :created
        else
            render json: { errors: goal.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @goal.update(goal_params)
            render json: @goal
        else
            render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @goal.destroy
        render json: { message: "削除しました" }
    end

    private

    def set_goal
        @goal = current_user.monthly_goals.find(params[:id])
    end

    def goal_params
        params.require(:monthly_goal).permit(:goal_date, :content, :achievement_rate)
    end
end
