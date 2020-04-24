class CommentsController < ApplicationController

    def index
        if params.has_key?(:user_id)
            @comments = Comment.where(user_id: params[:user_id])
        elsif params.has_key?(:artwork_id)
            @comments = Comment.where(artwork_id: params[:artwork_id])
        else
            @comments = Comment.all
        end

        render json: @comments
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.artwork_id = params[:artwork_id])

        if @comment.save
            render json: @comment
        else
            render json: @comment.errors.full_messages, status: 422
        end
    end

    def destroy
        @comment = Comment.find(param[:id])
        @comment.destroy
    end 

    private

    def comment_params
        params.require(:comment).permit(:user_id, :body)
    end

end 