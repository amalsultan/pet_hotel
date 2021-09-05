defmodule PetHotelWeb.AccountResolver do
  @moduledoc """
    This module resolves graphQL queries and mutations of user accounts and forwards request to respective context PetHotel.Accounts
  """
  alias PetHotel.Accounts

  @doc """
  Resolves the qraphQL mutation sign_up and forwards request to Accounts context which creates new user
  """
  def signup(_root, args, _info) do
      with {:ok, created_user} <- Accounts.create_user(args) do
        {:ok, created_user}
      else
        {:error, message} -> {:error, message}
        _ -> {:error, :failed}
      end
  end

  @doc """
  Resolves the qraphQL mutation change_password and forwards request to Accounts context which changes password of user
  """
  def change_password(_root, %{current_password: current_password} = args, %{context: %{current_user: %{email: email} = current_user}}) do
      with {:ok, _user} <- Accounts.authenticate(email, current_password),
           {:ok, user} <- current_user |> Accounts.change_password(args) do
        {:ok, user}
      else
        {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
        {:error, _msg} -> {:error, "Password is not valid"}
      end
  end

end
