defmodule Project2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :display_name, :string
    field :email, :string
    field :password_hash, :string
    field :points, :integer
    field :hometown, :string
    field :pw_last_try, :utc_datetime
    has_many :posts, Project2.Posts.Post
    # friends will be represented in a relations table...
    #many_to_many :friends, Project2.Users.User, join_through: "friends"

    timestamps()
  end

  # api validation here?
  defp validate_hometown(changeset) do
    hometown = get_field(changeset, :hometown)
    arr = hometown && String.split(hometown, ",")
    IO.inspect(arr)
    if !arr or length(arr) != 2 do
      add_error(changeset, :hometown, "hometown be formatted CITY, COUNTRY_CODE")
    else 
      city = String.trim(Enum.at(arr, 0))
      country_code = String.trim(Enum.at(arr, 1))

      api_key = "e6d0c89e30239fe1489387d434108f24"
      url = "api.openweathermap.org/data/2.5/weather?q=#{city},#{country_code}&appid=#{api_key}"
      
      {:ok, response} =  HTTPoison.get(url, [], []) 
      
      json = Poison.decode!(response.body)
      # check for 200 status code
      case json["cod"] do
        200 -> changeset
        _ -> add_error(changeset, :hometown, "hometown not found")
      end 
    end
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :display_name, :password_hash, :points, :hometown, :pw_last_try])
    |> validate_required([:email, :display_name, :password_hash, :points, :hometown, :pw_last_try])
    |> validate_format(:email, ~r/@/)
    |> validate_hometown
    |> unique_constraint(:email)
  end
end
