defmodule PetHotel.PetOwners do
  @moduledoc """
  The PetOwners context.
  """

  import Ecto.Query, warn: false
  alias PetHotel.Repo
  import Ecto.Query
  alias PetHotel.PetOwners.PetOwner

  @doc """
  Returns the list of pet_owners.

  ## Examples

      iex> list_pet_owners()
      [%PetOwner{}, ...]

  """
  def list_pet_owners do
    Repo.all(PetOwner)
    |> case do
      [] -> {:ok, :no_data_found}
      pet_owners -> {:ok, pet_owners}
    end
  end

   @doc """
  Returns the paginated list of pet_owners

  ## Examples

      iex> list_pet_owners(%{page_size: 10, page: 1})
      [%PetOwner{}, ...]

  """
  def list_pet_owners(%{page_size: page_size, page: page}) do
    page_offset = page_size * (page - 1)
    query = from p in "pet_owners",
              select: %{id: p.id, name: p.name}

    query
    |> limit(^page_size)
    |> offset(^page_offset)
    |> Repo.all
    |> case do
      [] -> {:ok, :no_data_found}
      pet_owners -> {:ok, pet_owners}
    end
  end

  @doc """
  Gets a single pet_owner.

  Raises `Ecto.NoResultsError` if the Pet owner does not exist.

  ## Examples

      iex> get_pet_owner!(123)
      %PetOwner{}

      iex> get_pet_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet_owner!(id) do
    try do
      result =
        Repo.get!(PetOwner, id)

      {:ok, result}
    rescue
      Ecto.NoResultsError ->
        {:error, :no_data_found}
    end
  end
  @doc """
  Creates a pet_owner. If the id is not given then system generates id  automatically

  ## Examples

      iex> create_pet_owner(%{id: 12, name: "Amal"})
      {:ok, %PetOwner{}}

      iex> create_pet_owner(%{name: "Amal"})
      {:ok, %PetOwner{}}

      iex> create_pet_owner(%{id: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet_owner(%{id: id} = attrs) do
    id
    |> get_pet_owner!()
    |> case do
      {:ok, _} -> {:error, :duplicate_data}
      {:error, _} ->
        %PetOwner{}
        |> PetOwner.changeset(attrs)
        |> Repo.insert()
        |> case do
          {:ok, petOwner} -> {:ok, petOwner}
          {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        end
    end
  end

  def create_pet_owner(attrs) do
    %PetOwner{}
    |> PetOwner.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, petOwner} -> {:ok, petOwner}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
    end
  end

  @doc """
  Updates a pet_owner.

  ## Examples

      iex> update_pet_owner(pet_owner, %{id: 1, name: "Saleha"})
      {:ok, %PetOwner{}}

      iex> update_pet_owner(pet_owner, %{id: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet_owner(%{id: id} = attrs) do
    id
    |> get_pet_owner!()
    |> case do
      {:ok, pet_owner} ->
        pet_owner
        |> PetOwner.changeset(attrs)
        |> Repo.update()
        |> case do
          {:ok, petOwner} -> {:ok, petOwner}
          {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        end
      {:error, error_message} -> {:error, error_message}
    end
  end

  @doc """
  Deletes a pet_owner.

  ## Examples

      iex> delete(pet_owner_id)
      {:ok, true}

      iex> delete(pet_owner_id)
      {:error, %Ecto.Changeset{}}

  """
  def delete(pet_owner_id) do
    pet_owner_id
    |> get_pet_owner!()
    |> case do
      {:ok, pet_owner} ->
        pet_owner
        |> Repo.delete()
        |> case do
          {:ok, _} -> {:ok, true}
          {:error, _error} -> {:error, :deletion_failed}
        end
      {:error, error} -> {:error, error}
    end
  end
end
