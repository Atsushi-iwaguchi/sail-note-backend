class Api::V1::PracticeRecordsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_record, only: [ :update, :destroy ]

    def index
        records = PracticeRecord
                    .from_date(params[:from_date])
                    .to_date(params[:to_date])
                    .wind_direction(params[:wind_direction])
                    .min_wind(params[:min_wind_speed])
                    .max_wind(params[:max_wind_speed])
                    .order(created_at: :desc)
        render json: records.map { |record| record_json(record) }
    end

    def create
        record = current_user.practice_records.build(record_params)

        if record.save
        render json: record_json(record), status: :created
        else
        render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        record = PracticeRecord.find(params[:id])
        render json: record_json(record)
    end

    def destroy
        @record.destroy
        render json: { message: "削除しました" }
    end

    def update
        if @record.update(record_params)
        render json: record_json(@record)
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
        :temperature,
        images: []
        )
    end

    def record_json(record)
        record.as_json(
        include: {
            user: {
            only: [ :id, :username ]
            }
        }
        ).merge(
        images: record.images.map do |image|
            {
            url: url_for(image)
            }
        end
        )
    end
end
