defmodule PetHotelWeb.PetResolver do
  @moduledoc """
    This module resolves graphQL queries and mutations of pets and forwards request to respective context
  """
  alias PetHotel.Pets

  @doc """
  Resolves the qraphQL mutation create_pet and forwards request to Pets context which creates new pet
  """
  def create_pet(_root, %{input: pet_data}, _info) do
    Pets.create_pet(pet_data)
  end

  @doc """
  Resolves the qraphQL mutation update_pet and forwards request to Pets context which updates pet data
  """
  def update_pet(_root, %{input: pet_data}, _info) do
    Pets.update_pet(pet_data)
  end

  @doc """
  Resolves the qraphQL mutation delete_pet and forwards request to Pets context which deletes pet data
  """
  def delete_pet(_root, %{id: pet_id}, _info) do
    Pets.delete(pet_id)
  end

  @doc """
    Resolves the qraphQL query all_pets and forwards request to Pets context which gets pets data
  """
  def all_pets(_root, args, _info) do
    Pets.list_pets(args)
  end


  @doc """
    Resolves the qraphQL query get_pet and forwards request to Pets context which gets pet data
    """
  def get_pet(_root, %{id: pet_id}, _info) do
    Pets.get_pet!(pet_id)
  end
end
