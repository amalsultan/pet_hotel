defmodule PetHotelWeb.GraphQL.PetOwnerTypes do
  @moduledoc """
    This module defines the graphQL Schema of pet owners. It includes create, update, delete and list apis schema
  """
  use Absinthe.Schema.Notation
  alias PetHotelWeb.PetOwnerResolver

  #Objects
  @desc "pet owner"
  object :pet_owner do
    field(:id, :integer)
    field(:name, :string)
  end

  #inputs
  @desc "pet owner input"
  input_object :pet_owner_input do
    field(:id, :integer)
    field(:name, non_null(:string))
  end

  @desc "update pet owner input"
  input_object :update_pet_owner_input do
    field(:id, non_null(:integer))
    field(:name, :string)
  end

  #mutations
  object :pet_owner_mutations do
    @desc "create new pet owner"
    field :create_pet_owner, :pet_owner do
      arg(:input, :pet_owner_input)
      resolve(&PetOwnerResolver.create_pet_owner/3)
    end

    @desc "update existing pet_owner"
    field :update_pet_owner, :pet_owner do
      arg(:input, :update_pet_owner_input)
      resolve(&PetOwnerResolver.update_pet_owner/3)
    end

    @desc "delete pet_owner data"
    field :delete_pet_owner, :boolean do
      arg(:id, :integer)
      resolve(&PetOwnerResolver.delete_pet_owner/3)
    end

  end

  #Queries

  object :pet_owner_queries do
    @desc "get pet_owner"
    field :get_pet_owner, :pet_owner do
      arg(:id, non_null(:integer))
      resolve(&PetOwnerResolver.get_pet_owner/3)

    end

    @desc "get all pet owners list"
    field :pet_owners, list_of(:pet_owner) do
      arg(:page_size, :integer, default_value: 10)
      arg(:page, :integer, default_value: 1)
      resolve(&PetOwnerResolver.all_pet_owners/3)

    end
  end
end
