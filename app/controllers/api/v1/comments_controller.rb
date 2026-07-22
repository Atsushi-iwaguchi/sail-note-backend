class Api::V1::CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_practice_record, only: [:index, :create]

    def index
        comments = @practice_record.comments

        render json: comments
    end

    def create
        comment = current_user.comments.build(
            practice_record: @practice_record,
            content: comment_params[:content]
            )
        
        if comment.save
            render json: comment, status: :created
        else
            render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        comment = current_user.comments.find(params[:id])
        comment.destroy
        render json: { message: "削除できました" }
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_practice_record
        @practice_record = PracticeRecord.find(params[:practice_record_id])
    end

end
