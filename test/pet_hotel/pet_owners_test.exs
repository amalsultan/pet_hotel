defmodule PetHotel.PetOwnersTest do
  use PetHotel.DataCase

  alias PetHotel.PetOwners

  describe "pet_owners" do
    alias PetHotel.PetOwners.PetOwner

    @valid_attrs %{name: "some name"}
    @update_attrs %{id: 2, name: "some updated name"}
    @invalid_attrs %{id: nil, name: nil}

    def pet_owner_fixture(attrs \\ %{}) do
      {:ok, pet_owner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PetOwners.create_pet_owner()

      pet_owner
    end

    test "get_pet_owner!/1 returns the pet_owner with given id" do
      pet_owner = pet_owner_fixture()
      assert PetOwners.get_pet_owner!(pet_owner.id) == {:ok, pet_owner}
    end

    test "create_pet_owner/1 with valid data creates a pet_owner" do
      assert {:ok, %PetOwner{} = pet_owner} = PetOwners.create_pet_owner(@valid_attrs)
      assert pet_owner.name == "some name"
    end

    test "create_pet_owner/1 with invalid data returns error changeset" do
      assert {:error, :invalid_input} = PetOwners.create_pet_owner(@invalid_attrs)
    end

    test "update_pet_owner/2 with valid data updates the pet_owner" do
      assert {:ok, %PetOwner{} = pet_owner} = PetOwners.update_pet_owner(@update_attrs)
      assert pet_owner.name == "some updated name"
    end

    test "update_pet_owner/2 with invalid data returns error changeset" do
      pet_owner = pet_owner_fixture()
      assert {:error, :invalid_input} = PetOwners.update_pet_owner(@invalid_attrs)
      assert {:ok, pet_owner} == PetOwners.get_pet_owner!(pet_owner.id)
    end

    test "delete_pet_owner/1 deletes the pet_owner" do
      pet_owner = pet_owner_fixture()
      assert {:ok, true} = PetOwners.delete(pet_owner.id)
      assert {:error, _} = PetOwners.get_pet_owner!(pet_owner.id)
    end
  end
end
