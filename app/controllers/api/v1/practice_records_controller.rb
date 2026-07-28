class Api::V1::PracticeRecordsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_record, only: [ :update, :destroy ]

    def index
        # 記事を新しい順にする
        records = PracticeRecord.order(created_at: :desc)
        render json: records.as_json(
            include: {
                user: {
                    only: [ :id, :username ]
                }
            }
        )
    end

    def create
        record = current_user.practice_records.build(record_params)

        if record.save
            render json: record, status: :created
        else
            render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        record = PracticeRecord.find(params[:id])
        render json: record.as_json(
            include: {
                user: {
                    only: [ :id, :username ]
                }
            }
        )
    end

    def destroy
        @record.destroy
        render json: { message: "削除しました" }
    end

    def update
        if @record.update(record_params)
            render json: @record
        else
            render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def set_record
        @record = current_user.practice_records.find(params[:id])
    end

    def record_params
        params.require(:practice_record).permit(
            :practice_date,
            :wind_direction,
            :min_wind_speed,
            :max_wind_speed,
            :tide,
            :mast_rake,
            :mast_bend,
            :mast_spreader_angle,
            :mast_spreader_length,
            :mast_tension,
            :content,
            :reflection,
            :weather,
            :temperature
        )
    end
end
