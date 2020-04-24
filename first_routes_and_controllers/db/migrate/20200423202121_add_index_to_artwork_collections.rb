class AddIndexToArtworkCollections < ActiveRecord::Migration[5.2]
  def change
    add_index :artwork_collections, :title
  end
end
