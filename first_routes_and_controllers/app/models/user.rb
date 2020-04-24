class User < ApplicationRecord
    validates :username, presence: true

    has_many :artworks,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :Artwork
    
    has_many :comments, dependent: :destroy
    
    has_many :likes

    has_many :liked_comments,
        through: :likes,
        source_type: :Comment,
        source: :likeable

    has_many :liked_artworks,
        through: :likes,
        source_type: :Artwork,
        source: :likeable
end
