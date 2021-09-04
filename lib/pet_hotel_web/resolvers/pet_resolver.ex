defmodule PetHotelWeb.PetResolver do
  alias PetHotel.Pets

  def create_pet(_root, %{input: pet_data}, _info) do
    Pets.create_pet(pet_data)
  end

  def update_pet(_root, %{input: pet_data}, _info) do
    Pets.update_pet(pet_data)
  end

  def delete_pet(_root, %{id: pet_id}, _info) do
    Pets.delete(pet_id)
  end

  def all_pets(_root, args, _info) do
    Pets.list_pets(args)
  end

  def get_pet(_root, %{id: pet_id}, _info) do
    Pets.get_pet!(pet_id)
  end
end
