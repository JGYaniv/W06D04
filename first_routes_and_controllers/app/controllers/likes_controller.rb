class LikesController < ApplicationController
    def index
        if params[:user_id]
            @likes = Like.where(user_id: params[:user_id])
        elsif params[:artwork_id]
            @likes = Like.where(likeable_id: params[:artwork_id])
        elsif params[:comment_id]
            @likes = Like.where(likeable_id: params[:comment_id])
        else
            @likes = Like.all
        end

        render json: @likes
    end

    def create
        @like = Like.new(like_params)
        if @like.save
            render json: @like
        else
            #error
            render json: @like.errors.full_messages, status: 422
        end
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
    end
end