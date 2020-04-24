# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Artwork.delete_all
ArtworkShare.delete_all
Comment.delete_all
Like.delete_all

User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
Artwork.connection.execute('ALTER SEQUENCE artworks_id_seq RESTART WITH 1')
ArtworkShare.connection.execute('ALTER SEQUENCE artwork_shares_id_seq RESTART WITH 1')
Comment.connection.execute('ALTER SEQUENCE comments_id_seq RESTART WITH 1')
Like.connection.execute('ALTER SEQUENCE likes_id_seq RESTART WITH 1')

u1 = User.create!(username: "Jonathan1")
u2 = User.create!(username: "Jonathan2")
u3 = User.create!(username: "Jonathan3")
u4 = User.create!(username: "Jonathan4")

a1 = Artwork.create(name: "Moana Lisa", artist_id: u1.id, image_url: "https://i.imgur.com/F6Qyi.jpg")
a2 = Artwork.create(name: "Homer & Lisa", artist_id: u2.id, image_url: "https://i.imgur.com/5PBeByJ.png")

ArtworkShare.create(user_id: u1.id, artwork_id: a2.id)
ArtworkShare.create(user_id: u2.id, artwork_id: a1.id)
ArtworkShare.create(user_id: u3.id, artwork_id: a2.id)
ArtworkShare.create(user_id: u4.id, artwork_id: a1.id)
ArtworkShare.create(user_id: u1.id, artwork_id: a1.id)
ArtworkShare.create(user_id: u4.id, artwork_id: a2.id)

c1 = Comment.create(user_id: u1.id, artwork_id: a2.id, body: "*app academy way")
c2 = Comment.create(user_id: u3.id, artwork_id: a2.id, body: "OMEGALUL")
c3 = Comment.create(user_id: u4.id, artwork_id: a2.id, body: "Truth indeed")
c4 = Comment.create(user_id: u2.id, artwork_id: a1.id, body: "Dat duck face")
c5 = Comment.create(user_id: u3.id, artwork_id: a1.id, body: "AFLACK")

Like.create(user_id: u1.id, likeable_type: c1.class.to_s, likeable_id: c1.id) #c1.class.to_s => "Comment"
Like.create(user_id: u2.id, likeable_type: c1.class.to_s, likeable_id: c1.id)
Like.create(user_id: u3.id, likeable_type: c1.class.to_s, likeable_id: c1.id)
Like.create(user_id: u4.id, likeable_type: c1.class.to_s, likeable_id: c1.id)
Like.create(user_id: u1.id, likeable_type: c1.class.to_s, likeable_id: c5.id)
Like.create(user_id: u1.id, likeable_type: a1.class.to_s, likeable_id: a2.id)
Like.create(user_id: u2.id, likeable_type: a1.class.to_s, likeable_id: a1.id)
Like.create(user_id: u3.id, likeable_type: a1.class.to_s, likeable_id: a2.id)
Like.create(user_id: u4.id, likeable_type: a1.class.to_s, likeable_id: a2.id)

ArtworkCollection.create(user_id: u1.id, artwork_id: a2.id, title: "Faves")
ArtworkCollection.create(user_id: u1.id, artwork_id: a1.id, title: "Faves")
ArtworkCollection.create(user_id: u3.id, artwork_id: a1.id, title: "Beauties")