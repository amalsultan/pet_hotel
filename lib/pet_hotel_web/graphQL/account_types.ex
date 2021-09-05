defmodule PetHotelWeb.GraphQL.AccountTypes do

  @moduledoc """
    This module defines the graphQL Schema of users apis. It includes sign up and update password
  """
  use Absinthe.Schema.Notation
  alias PetHotelWeb.Middleware
  alias PetHotelWeb.AccountResolver

  #Objects
  @desc "An user entry, returns basic user information"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
  end

  #mutations
  object :accounts_mutations do
    @desc "Sign up"
    field :sign_up, :user do
      arg(:name, :string)
      arg(:email, :string)
      arg(:password, :string)
      arg(:password_confirmation, :string)

      resolve(&AccountResolver.signup/3)
    end

    @desc "Change user password"
    field :change_password, :user do
      arg(:password, :string)
      arg(:password_confirmation, :string)
      arg(:current_password, :string)
      middleware(Middleware.Authorize)

      resolve(&AccountResolver.change_password/3)
    end
  end
end
