# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Project2.Repo.insert!(%Project2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Project2.Repo

alias Project2.Users.User

pwhash = Argon2.hash_pwd_salt("password")

Repo.insert!(%User{email: "alice@example.com", display_name: "alice", password_hash: pwhash, hometown: "Lynn, US", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%User{email: "bob@example.com", display_name: "bobby", password_hash: pwhash, hometown: "Boston, US", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%User{email: "cal@example.com", display_name: "cal", password_hash: pwhash, hometown: "Boston, US", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%User{email: "dee@example.com", display_name: "dee", password_hash: pwhash, hometown: "Salem, US", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%User{email: "eni@example.com", display_name: "eni", password_hash: pwhash, hometown: "Atlanta, US", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})

alias Project2.Friends.Friend
Repo.insert!(%Friend{lower_user_id: 1, higher_user_id: 2})

alias Project2.Friends.FriendRequest
Repo.insert!(%FriendRequest{sender_id: 1, receiver_id: 3})
Repo.insert!(%FriendRequest{sender_id: 4, receiver_id: 1})

alias Project2.Posts.Post

Repo.insert!(%Post{content: "I baked some chocolate chip cookies!", user_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%Post{content: "I baked some more cookies!", user_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%Post{content: "I baked some banana bread!", user_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})

alias Project2.Replies.Reply

Repo.insert!(%Reply{content: "Wow I could go for some of those...", user_id: 2, post_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})

alias Project2.Pokes.Poke
Repo.insert!(%Poke{sender: 2, recipient: 1})

alias Project2.Notifications.Notification

Repo.insert!(%Notification{ent_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second), type: "reply", user_id: 1, actor_id: 2})
Repo.insert!(%Notification{ent_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second), type: "poke", user_id: 1, actor_id: 2})
