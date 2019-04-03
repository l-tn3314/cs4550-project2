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

Repo.insert!(%User{email: "alice@example.com", display_name: "alice", password_hash: pwhash, hometown: "San Bernadino", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})
Repo.insert!(%User{email: "bob@example.com", display_name: "bobby", password_hash: pwhash, hometown: "Boston", pw_last_try: DateTime.truncate(DateTime.utc_now(), :second)})

alias Project2.Posts.Post

Repo.insert!(%Post{content: "I baked some chocolate chip cookies!", user_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})

alias Project2.Replies.Reply

Repo.insert!(%Reply{content: "Wow I could go for some of those...", user_id: 2, post_id: 1, time: DateTime.truncate(DateTime.utc_now(), :second)})
