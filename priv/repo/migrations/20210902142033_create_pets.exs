defmodule PetHotel.Repo.Migrations.CreatePets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string
      add :pet_owner_id, references(:pet_owners)
      add :type, :string
      add :breed, :string

      timestamps()
    end

  end
end
