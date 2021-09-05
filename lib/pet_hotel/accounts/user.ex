defmodule PetHotel.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PetHotel.Accounts.User

  schema "users" do
    field(:email, :string)
    field(:name, :string)

    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:password_hash, :binary)
    field(:access_token, :string)
    field(:role, :string, default: "user")

    timestamps()
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    attrs = attrs |> Map.delete(:password)

    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def changeset(%User{} = user, attrs, :password) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password, message: "Ne correspond pas")
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  @spec put_pass_hash(Ecto.Changeset.t()) :: Ecto.Changeset.t() | no_return
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        {:ok, pass_hash} = PetHotel.Vault.encrypt(pass)
        put_change(changeset, :password_hash, pass_hash)

      _ ->
        changeset
    end
  end
end
