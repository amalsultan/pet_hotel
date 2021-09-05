defmodule PetHotelWeb.AuthResolver do
  @moduledoc """
    This module resolves graphQL mutations related to authentication and forwards request to respective context PetHotel.Accounts
  """
  alias PetHotel.Accounts

  @doc """
  Resolves the qraphQL mutation sign_in and forwards request to Accounts context which authenticates user and generates a JWT token
  """
  def signin(_, args, _context) do
    with {:ok, user} <- Accounts.authenticate(args[:email], args[:password]),
        {:ok, token} <- Accounts.generate_access_token(user) do
          {:ok, %{token: token}}
      else
        {:error, msg} ->
          {:error, msg}

        :error ->
          {:error, :invalid_credentials}
      end
  end

end
