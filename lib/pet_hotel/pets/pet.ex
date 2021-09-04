defmodule PetHotel.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :breed, :string
    field :name, :string
    field :pet_owner_id, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:id, :name, :pet_owner_id, :type, :breed])
    |> validate_required([:id, :name, :pet_owner_id])
  end
end
