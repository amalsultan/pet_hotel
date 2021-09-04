defmodule PetHotel.PetOwners.PetOwner do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "pet_owners" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pet_owner, attrs) do
    pet_owner
    |> cast(attrs, [:id, :name])
    |> validate_required([:name])
  end
end
