defmodule Project2.PokesTest do
  use Project2.DataCase

  alias Project2.Pokes

  describe "pokes" do
    alias Project2.Pokes.Poke

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def poke_fixture(attrs \\ %{}) do
      {:ok, poke} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pokes.create_poke()

      poke
    end

    test "list_pokes/0 returns all pokes" do
      poke = poke_fixture()
      assert Pokes.list_pokes() == [poke]
    end

    test "get_poke!/1 returns the poke with given id" do
      poke = poke_fixture()
      assert Pokes.get_poke!(poke.id) == poke
    end

    test "create_poke/1 with valid data creates a poke" do
      assert {:ok, %Poke{} = poke} = Pokes.create_poke(@valid_attrs)
    end

    test "create_poke/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pokes.create_poke(@invalid_attrs)
    end

    test "update_poke/2 with valid data updates the poke" do
      poke = poke_fixture()
      assert {:ok, %Poke{} = poke} = Pokes.update_poke(poke, @update_attrs)
    end

    test "update_poke/2 with invalid data returns error changeset" do
      poke = poke_fixture()
      assert {:error, %Ecto.Changeset{}} = Pokes.update_poke(poke, @invalid_attrs)
      assert poke == Pokes.get_poke!(poke.id)
    end

    test "delete_poke/1 deletes the poke" do
      poke = poke_fixture()
      assert {:ok, %Poke{}} = Pokes.delete_poke(poke)
      assert_raise Ecto.NoResultsError, fn -> Pokes.get_poke!(poke.id) end
    end

    test "change_poke/1 returns a poke changeset" do
      poke = poke_fixture()
      assert %Ecto.Changeset{} = Pokes.change_poke(poke)
    end
  end
end
