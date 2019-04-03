defmodule Project2Web.PokeView do
  use Project2Web, :view
  alias Project2Web.PokeView

  def render("index.json", %{pokes: pokes}) do
    %{data: render_many(pokes, PokeView, "poke.json")}
  end

  def render("show.json", %{poke: poke}) do
    %{data: render_one(poke, PokeView, "poke.json")}
  end

  def render("poke.json", %{poke: poke}) do
    %{id: poke.id}
  end
end
