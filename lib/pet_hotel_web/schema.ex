defmodule PetHotelWeb.Schema do
  @moduledoc """
  This module defines the graphQL Schema for pet_hotel apis. It imports queries and mutations from different modules to expose it for api usage
  """
  use Absinthe.Schema

  import_types(PetHotelWeb.GraphQL.PetOwnerTypes)
  import_types(PetHotelWeb.GraphQL.PetTypes)

  query do
    import_fields :pet_owner_queries
    import_fields :pet_queries
  end

  mutation do
    import_fields :pet_mutations
    import_fields :pet_owner_mutations
  end

end
