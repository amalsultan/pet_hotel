defmodule PetHotelWeb.PetOwnerResolver do
  alias PetHotel.PetOwners

  def create_pet_owner(_root, %{input: pet_owner_data}, _info) do
    PetOwners.create_pet_owner(pet_owner_data)
  end

  def update_pet_owner(_root, %{input: pet_owner_data}, _info) do
    PetOwners.update_pet_owner(pet_owner_data)
  end

  def delete_pet_owner(_root, %{id: pet_owner_id}, _info) do
    PetOwners.delete(pet_owner_id)
  end

  def get_pet_owner(_root, %{id: pet_owner_id}, _info) do
    PetOwners.get_pet_owner!(pet_owner_id)
  end

  def all_pet_owners(_root, %{page_size: _page_size, page: _page} = pagination, _info) do
    PetOwners.list_pet_owners(pagination)
  end
end
