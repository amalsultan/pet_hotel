defmodule PetHotel.PetOwnersTest do
  use PetHotel.DataCase

  alias PetHotel.PetOwners

  describe "pet_owners" do
    alias PetHotel.PetOwners.PetOwner

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def pet_owner_fixture(attrs \\ %{}) do
      {:ok, pet_owner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PetOwners.create_pet_owner()

      pet_owner
    end

    test "list_pet_owners/0 returns all pet_owners" do
      pet_owner = pet_owner_fixture()
      assert PetOwners.list_pet_owners() == [pet_owner]
    end

    test "get_pet_owner!/1 returns the pet_owner with given id" do
      pet_owner = pet_owner_fixture()
      assert PetOwners.get_pet_owner!(pet_owner.id) == pet_owner
    end

    test "create_pet_owner/1 with valid data creates a pet_owner" do
      assert {:ok, %PetOwner{} = pet_owner} = PetOwners.create_pet_owner(@valid_attrs)
      assert pet_owner.name == "some name"
    end

    test "create_pet_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetOwners.create_pet_owner(@invalid_attrs)
    end

    test "update_pet_owner/2 with valid data updates the pet_owner" do
      pet_owner = pet_owner_fixture()
      assert {:ok, %PetOwner{} = pet_owner} = PetOwners.update_pet_owner(pet_owner, @update_attrs)
      assert pet_owner.name == "some updated name"
    end

    test "update_pet_owner/2 with invalid data returns error changeset" do
      pet_owner = pet_owner_fixture()
      assert {:error, %Ecto.Changeset{}} = PetOwners.update_pet_owner(pet_owner, @invalid_attrs)
      assert pet_owner == PetOwners.get_pet_owner!(pet_owner.id)
    end

    test "delete_pet_owner/1 deletes the pet_owner" do
      pet_owner = pet_owner_fixture()
      assert {:ok, %PetOwner{}} = PetOwners.delete_pet_owner(pet_owner)
      assert_raise Ecto.NoResultsError, fn -> PetOwners.get_pet_owner!(pet_owner.id) end
    end

    test "change_pet_owner/1 returns a pet_owner changeset" do
      pet_owner = pet_owner_fixture()
      assert %Ecto.Changeset{} = PetOwners.change_pet_owner(pet_owner)
    end
  end
end
