class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :name, null: true
      t.integer :artist_id, null: true
      t.string :image_url, null: true

      t.timestamps
    end
    add_index :artworks, :artist_id
    add_index :users, :username, unique: true
  end
end
