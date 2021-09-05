defmodule PetHotel.Accounts do
  @moduledoc """
  Accounts context creates, updates user accounts details
  """
  import Ecto.Query, warn: false
  alias PetHotel.Repo
  alias PetHotel.Accounts.User
  alias PetHotel.AuthToken

  def get_user!(email) do
    try do
      result =
        Repo.get_by!(User, email: email)
      {:ok, result}
    rescue
      Ecto.NoResultsError ->
        {:error, :no_data_found}
    end
  end

  def create_user(%{email: email} = attrs) do
    email
    |> get_user!()
    |> case do
      {:ok, _} -> {:error, :duplicate_data}
      {:error, _} ->
        %User{}
        |> User.changeset(attrs, :password)
        |> Repo.insert()
        |> case do
          {:ok, petOwner} -> {:ok, petOwner}
          {:error, %Ecto.Changeset{errors: [email: {message, _}]} = _changeset} -> {:error, "email "<>message}
          {:error, %Ecto.Changeset{errors: [password_confirmation: {message, _}]} = _changeset} -> {:error, "password "<>message}
          {:error, %Ecto.Changeset{errors: [password: {message, _}]} = _changeset} -> {:error, "password "<>message}
          _-> {:error, :failed}
        end
    end
  end

  def change_password(%User{} = user, %{password: password, password_confirmation: password_confirmation}) do
    user
    |> User.changeset(%{password: password, password_confirmation: password_confirmation}, :password)
    |> Repo.update()
  end

  @doc """
  Generate an access token and associates it with the user
  """
  @spec generate_access_token(User.t()) :: {:ok, String.t()}
  def generate_access_token(user) do
    access_token = generate_token(user)
    Ecto.Changeset.change(user, access_token: access_token)
    |> Repo.update
    {:ok, access_token}
  end

  @spec generate_token(User.t()) :: String.t()
  defp generate_token(user) do
    claims = %{"user_id" => user.id}
    signer = Joken.Signer.create("HS256", "tempSecret")
    {:ok, token, _claims} = AuthToken.encode_and_sign(claims, signer)
    token
  end

  @spec revoke_access_token(User.t()) :: {:ok, User.t()} | {:error, any()}
  def revoke_access_token(user) do
    user_modified = Ecto.Changeset.change(user, access_token: nil)
    {:ok, _user} = Repo.update(user_modified)
  end

  @doc """
  Authenticate user with email and password
  """
  @spec authenticate(User.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def authenticate(nil, _password), do: {:error, :invalid_email}
  def authenticate(_email, nil), do: {:error, :invalid_password}

  def authenticate(email, password) do
    user = User |> Repo.get_by(email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :invalid_credentials}
    end
  end

  @spec check_password(User.t(), String.t()) :: boolean()
  defp check_password(user, password) do
    case user do
      nil -> false
      _ ->

        {:ok, decrypted_password} = PetHotel.Vault.decrypt(user.password_hash)
        if decrypted_password == password do
          true
        else
          false
        end
    end
  end
end
