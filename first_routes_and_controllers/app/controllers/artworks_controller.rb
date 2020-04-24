class ArtworksController < ApplicationController

    def index 
        if params.has_key?(:user_id)
            #arts.com/users/4/artworks
            @artworks = Artwork
                .where(artist_id: params[:user_id])
            
            @artworks_shared = Artwork
                .joins(:shares)
                .where(artwork_shares: {user_id: params[:user_id]})

            render json: (@artworks + @artworks_shared).uniq
        else
            @artworks = Artwork.all
            render json: @artworks
        end
    end

    def show
        @artwork = Artwork.find(params["id"])

        render json: @artwork
    end

    def update
        @artwork = Artwork.find(params["id"])

        if @artwork.update(artwork_params)
            render json: @artwork
        else
            render json: @artwork.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def create
        @artwork = Artwork.new(artwork_params)

        if @artwork.save
            render json: @artwork
        else
            render json: @artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        @artwork = Artwork.find(params["id"])

        @artwork.destroy
    end

    private

    def artwork_params
        params.require(:artwork).permit(:name, :artist_id, :image_url)
    end
end