defmodule PetHotel.Pets do
  alias PetHotel.PetOwners.PetOwner
  alias PetHotel.Pets.Pet
  @moduledoc """
  Pets context creates, updates, deletes and lists pets
  """

  import Ecto.Query, warn: false
  alias PetHotel.Repo

  alias PetHotel.Pets.Pet

  @doc """
  Returns query which lists all pets and loads pet owner id and name
  """
  def list_all_pets_query() do
    from p in Pet,
      join: po in PetOwner,
      on: p.pet_owner_id == po.id,
      select: %{id: p.id, name: p.name, type: p.type, breed: p.breed, pet_owner_id: p.pet_owner_id, pet_owner_name: po.name}
  end

  @doc """
  Returns query which lists all pets owned by given pet owner
  """
  def list_all_pets_query(pet_owner_id) do
    from p in Pet,
      join: po in PetOwner,
      on: p.pet_owner_id == po.id,
      select: %{id: p.id, name: p.name, type: p.type, breed: p.breed, pet_owner_id: p.pet_owner_id, pet_owner_name: po.name},
      where: p.pet_owner_id == ^pet_owner_id

  end
   @doc """
  Returns the list of pets. It returns the list of pets owned by given pet owner if pet owner id is given, otherwise it returns paginated list of all pets

  ## Examples

      iex> list_pets(%{page_size: 10, page: 1})
      [%Pet{}, ...]

      iex> list_pets(%{page_size: 10, page: 1, pet_owner_id: 1})
      [%Pet{}, ...]

  """
  def list_pets(%{page_size: page_size, page: page, pet_owner_id: pet_owner_id}) do
    page_offset = page_size * (page - 1)
    list_all_pets_query(pet_owner_id)
    |> limit(^page_size)
    |> offset(^page_offset)
    |> Repo.all
    |> case do
      [] -> {:ok, :no_data_found}
      pets -> {:ok, pets}
    end
  end

  def list_pets(%{page_size: page_size, page: page}) do
    page_offset = page_size * (page - 1)

    list_all_pets_query()
    |> limit(^page_size)
    |> offset(^page_offset)
    |> Repo.all
    |> case do
      [] -> {:ok, :no_data_found}
      pets -> {:ok, pets}
    end
  end


  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id) do
    try do
      result =
        Repo.get!(Pet, id)

      {:ok, result}
    rescue
      Ecto.NoResultsError ->
        {:error, :no_data_found}
    end
  end

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(%{id: id} = attrs) do
    id
    |> get_pet!()
    |> case do
      {:ok, _} -> {:error, :duplicate_data}
      {:error, _} ->
        %Pet{}
        |> Pet.changeset(attrs)
        |> Repo.insert()
        |> case do
          {:ok, pet} -> {:ok, pet}
          {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        end
    end
  end

  def create_pet(attrs) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, pet} -> {:ok, pet}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%{id: id} = attrs) do
    id
    |> get_pet!()
    |> case do
      {:ok, pet} ->
        pet
        |> Pet.changeset(attrs)
        |> Repo.update()
        |> case do
          {:ok, pet} -> {:ok, pet}
          {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        end
      {:error, error_message} -> {:error, error_message}
    end
  end

  @doc """
  Deletes a pet.

  ## Examples

      iex> delete(pet)
      {:ok, %Pet{}}

      iex> delete(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete(pet_id) do
    pet_id
    |> get_pet!()
    |> case do
      {:ok, pet} ->
        pet
        |> Repo.delete()
      {:error, error} -> {:error, error}
    end
  end
end
