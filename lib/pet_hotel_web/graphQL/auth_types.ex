defmodule PetHotelWeb.GraphQL.AuthTypes do

  @moduledoc """
    This module defines apis schema for user authentication
  """

  use Absinthe.Schema.Notation
  alias PetHotelWeb.AuthResolver

  #Objects
  @desc "token to authenticate user"
  object :session do
    field(:token, :string)
  end

  #mutations
  object :auth_mutations do
    @desc "Sign in"
    field :sign_in, :session do
      arg(:email, :string)
      arg(:password, :string)

      resolve(&AuthResolver.signin/3)
    end
  end
end
