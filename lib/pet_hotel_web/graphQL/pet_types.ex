defmodule PetHotelWeb.GraphQL.PetTypes do
    @moduledoc """
    This module defines the graphQL Schema of pets. It includes create, update, delete and list apis schema
  """
  use Absinthe.Schema.Notation
  alias PetHotelWeb.PetResolver

  #Objects
  @desc "pet"
  object :pet do
    field(:id, :id)
    field(:name, :string)
    field(:type, :string)
    field(:pet_owner_id, :integer)
    field(:pet_owner_name, :string)
    field(:breed, :string)
  end

  #inputs
  @desc "pet input"
  input_object :pet_input do
    field(:id, :integer)
    field(:name, non_null(:string))
    field(:type, :string)
    field(:pet_owner_id, non_null(:integer))
    field(:breed, :string)
  end

  @desc "update pet input"
  input_object :update_pet_input do
    field(:id, non_null(:integer))
    field(:name, :string)
    field(:type, :string)
    field(:pet_owner_id, :integer)
    field(:breed, :string)
  end

  #mutations
  object :pet_mutations do
    @desc "create new pet"
    field :create_pet, :pet do
      arg(:input, :pet_input)
      resolve(&PetResolver.create_pet/3)
    end

    @desc "update existing pet"
    field :update_pet, :pet do
      arg(:input, :update_pet_input)
      resolve(&PetResolver.update_pet/3)
    end

    @desc "delete pet data"
    field :delete_pet, :boolean do
      arg(:id, non_null(:integer))
      resolve(&PetResolver.delete_pet/3)
    end

  end
  #Queries
  object :pet_queries do

    @desc "get pet"
    field :get_pet, :pet do
      arg(:id, non_null(:integer))
      resolve(&PetResolver.get_pet/3)

    end

    @desc "get all pets"
    field :all_pets, list_of(:pet) do
      arg(:page_size, :integer, default_value: 10)
      arg(:page, :integer, default_value: 1)
      arg(:pet_owner_id, :integer)
      resolve(&PetResolver.all_pets/3)

    end
  end
end
