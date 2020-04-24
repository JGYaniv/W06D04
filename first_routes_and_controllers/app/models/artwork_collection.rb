class ArtworkCollection < ApplicationRecord
    belongs_to :collector,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    
    has_one :artwork,
        primary_key: :artwork_id,
        foreign_key: :id,
        class_name: :Artwork
    #SELECT artworks.id 
    #FROM artworks 
    #JOIN artwork_collections ON artworks.id = artwork_collections.artwork_id
    #WHERE artworks_collection.id = ?
end