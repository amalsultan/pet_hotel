defmodule PetHotel.Repo.Migrations.CreatePetOwners do
  use Ecto.Migration

  def change do
    create table(:pet_owners) do
      add :name, :string

      timestamps()
    end

  end
end
