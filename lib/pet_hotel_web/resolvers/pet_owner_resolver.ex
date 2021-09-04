defmodule PetHotelWeb.PetOwnerResolver do
    @moduledoc """
    This module resolves graphQL queries and mutations of pet owner and forwards request to respective context
  """
  alias PetHotel.PetOwners


  @doc """
  Resolves the qraphQL mutation create_pet_owner and forwards request to PetOwners context which creates new pet owner
  """
  def create_pet_owner(_root, %{input: pet_owner_data}, _info) do
    PetOwners.create_pet_owner(pet_owner_data)
  end

  @doc """
  Resolves the qraphQL mutation update_pet_owner and forwards request to PetOwners context which updates pet owner
  """
  def update_pet_owner(_root, %{input: pet_owner_data}, _info) do
    PetOwners.update_pet_owner(pet_owner_data)
  end

  @doc """
  Resolves the qraphQL mutation delete_pet_owner and forwards request to PetOwners context which deletes pet owner
  """
  def delete_pet_owner(_root, %{id: pet_owner_id}, _info) do
    PetOwners.delete(pet_owner_id)
  end

  @doc """
    Resolves the qraphQL query get_pet_owner and forwards request to PetOwners context which gets pet owner
    """
  def get_pet_owner(_root, %{id: pet_owner_id}, _info) do
    PetOwners.get_pet_owner!(pet_owner_id)
  end


  @doc """
    Resolves the qraphQL query all_pet_owners and forwards request to PetOwners context which gets pet owners data
    """
  def all_pet_owners(_root, %{page_size: _page_size, page: _page} = pagination, _info) do
    PetOwners.list_pet_owners(pagination)
  end
end
