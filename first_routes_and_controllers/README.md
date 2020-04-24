Phase II: Users and Artworks API
Overview
Next let's move to the API layer. The API describes how you will expose your data and specifies how the outside world can interact with it. Today we'll be using the Postman web app to test our API endpoints. When debugging make sure to reference your Rails server log. It will provide you will valuable insight as to what's going wrong.

Instructions
First, make sure the User controller actions you created in the previous project are all working. They should do the following:

user_params helper method
This method should be private. It requires the key :user in params, and permits each of the user attributes as keys in the nested hash.

create (POST /users)
Remember to use if user.save to check if validations passed. On error, this action should render validation errors using user.errors.full_messages. Set the status code to indicate error.

destroy (DELETE /users/:id)
Finds the user (we can lookup the id in params[:id]) and destroys the object (using the destroy method on the user instance). Best practice is to render the destroyed user after destroying it in the database. Use dependent: :destroy in the artworks and artwork_shares associations on User. This ensures that the associated records are also destroyed.

N.B. There is another ActiveRecord method that removes objects from your database, delete; however, this method does not run callbacks such as dependent: :destroy, and is therefore not the method we want to use.

index (GET /users)
Renders all the users in the database.

show (GET /users/:id)
Renders a single user, using the :id in params[:id].

update (PATCH /users/:id)
Finds the requested user. Use update with user_params to do a mass-assignment update and save. Render validation errors using user.errors.full_messages. Don't forget the status code!

Now let's move to the routes.rb file. You should already have routes for the users controller from the previous project. Use the only: option for resources to restrict to just the five actions above for the users controller. There should be six routes in total; remember that Rails will generate both patch and put routes for the update action.

Next, move on to creating ArtworksController. Build the same five actions and params helper method. Your code should look very similar, but practice this a second time.

Hint: For this project, do not write any authentication or authorization logic. When creating a new artwork, require the uploader submit their artist_id. This isn't secure because anyone could always take your artist_id and upload new artworks in your name. For now, let's assume the users of our service aren't malicious :-)

Recap
Congratulations! You should now have tables, models, and controllers for users and artworks. Before moving on, test that your API endpoints are working with Postman. Then call over a TA and explain your code.

Phase III: Sharing Artworks
Overview
Now we're going to add routes and controllers for our ArtworkShares. The artwork_shares table is a join table, so while RESTful design patterns still apply, our ArtworkShares controller will look a little different from the controllers we just wrote. All we need to be able to do is share and unshare artworks. What controller actions do you think we'll need?

Once we have sharing working, we'll refactor ArtworksController#index so that it returns artworks either belonging to or shared with a particular user. In order to make this work we'll need to pass in the user_id to our index action so we can filter for the appropriate works.

Instructions
Add a new resources routes and controller for ArtworkShare. Include the following actions and associated routes.

create (POST /artwork_shares)
You'll want to pass the artwork_id and the viewer_id. Also, use strong parameters by writing an artwork_share_params helper method that will whitelist the ArtworkShare attributes.

destroy (DELETE /artwork_shares/:id)
This un-shares an Artwork with a User. To delete a share, the user should issue a DELETE to /artwork_shares/123, where 123 is the id of the ArtworkShare to destroy.

After we create ArtworkShare records, we will want to return the record to the client. We will want to do the same thing upon deletion of ArtworkShare records. Both of these routes should conventionally render the created/destroyed ArtworkShare as the response.

We won't need any of the other routes, so you can use only: to restrict them.

Use Postman to make sure that your controller's create and destroy actions work properly. Remember, our validations should prevent us from sharing the same artwork with the same user more than once.

User's Artworks: nested routes
We want to be able to fetch the Artworks of a particular user. However, right now a GET to /artworks gets all of the artworks in the system.

Let's add a new, nested resource, /users/:user_id/artworks, so that we can get the artworks for a given user. We'll only need the index action for this.

You may remove the index action from the top-level artworks resource. This will modify our API so that a user can't download all the artworks in one go, but instead only per-user. For example, you will be able to get user 1's artworks through GET /users/1/artworks, user 2's through GET /users/2/artworks, etc.

The nested resource will still hit ArtworksController#index. Rewrite the index method to return:

the Artworks owned by a user and
the Artworks shared with the user.
You can access the specified user through params[:user_id] because it is part of the nested route.

Use Postman to make sure your modified index method in the ArtworksController returns all art owned by and shared with a user.

Recap
At this point in the project you should be able to create ArtworkShares with Postman. Artworks shared with a particular user should also be included in data returned by a GET request to ArtworksController#index.