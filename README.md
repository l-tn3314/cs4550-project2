# Project2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
-------
## Project Requirements

* In general, this application should be significantly more ambitious and have more features and functions than either the memory game or the task tracker app.
* The server side logic of your app must be built using Elixir / Phoenix.
* Exception: If you separate "front end" from "back end" as two separate programs, then only the "back end" needs to be Elixir / Phoenix.
* Your application must have significant server-side / back-end logic.
* All of your app must be deployed to the VPS(es) of one or more members of your team.
* If you can self-host things on your VPS, you should. For example, don't use an asset from a CDN when you can put it in your webpack bundle.
* Your application should have user accounts, and should support local password authentication (implemented securely).
* Users should be stored in a Postgres database, along with some other persistent state.
* Your application should use an external API that requires authentication of your app, your app's user, or both.
* Any API access should be server <-> server. Your browser code should only make requests to your server, not remote APIs.
* Exception: You can use maps or multimedia playback APIs from the browser if you also have other significant server <-> server API calls.
* Your application should use Phoenix Channels to push realtime updates to users, triggered either from an external API or from actions by other concurrent users.

App
Features
Search
Users are able to search using keywords (API call using those keywords as the query), results w/ thumbnails?(thumbnails can be filtered for! There is a Boolean available! So we can display those.)

Favorite
Users should be able to favorite records and save them to a list (nice-to-have: users have multiple lists they can add favorited items to)

European Museum/Gallery 
Requirements
secure local password authentication ( I think local means not passing authentication off to Facebook or the API) *yes no google or facebook authentication 
users in Postgres. Users have history lists, favorites, and friends lists. (Friendship should go both ways. Both have to accept.) * the follow model as on twitter or instagram is simpler to implement
real time updates from actions by other concurrent users (share works with other users)
(Note: I think all the other requirements would be  satisfied/given) 

-------------
- Points shown on user profile 
- Leaderboard among friends
- Earn/lose points depending on weather
- See how friends are doing

