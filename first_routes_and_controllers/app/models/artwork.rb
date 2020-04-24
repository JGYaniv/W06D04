class Artwork < ApplicationRecord
    validates :artist_id, presence: true
    validates :name, presence: true
    validates :image_url, presence: true
    validate :unique_title

    belongs_to :artist,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :User

    has_many :shares,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare

    has_many :comments, dependent: :destroy
    
    has_many :likes, :as => :likeable
            
    def unique_title
        other_works = artist.artworks.map(&:name)
        
        if other_works.include?(self.name)
            errors[:artwork] << "cannot not have two works with the same name"
        end
    end
end
