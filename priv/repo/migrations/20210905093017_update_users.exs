defmodule PetHotel.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

    def up do
      alter table("users") do
        remove :password_hash
        add :password_hash, :binary
      end
    end

    def down do
      alter table("users") do
        remove :password_hash
        add :password_hash, :string
      end
    end
end
