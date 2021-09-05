defmodule PetHotelWeb.Schema do
  @moduledoc """
  This module defines the graphQL Schema for pet_hotel apis. It imports queries and mutations from different modules to expose it for api usage
  """
  use Absinthe.Schema

  import_types(PetHotelWeb.GraphQL.PetOwnerTypes)
  import_types(PetHotelWeb.GraphQL.PetTypes)
  import_types(PetHotelWeb.GraphQL.AccountTypes)
  import_types(PetHotelWeb.GraphQL.AuthTypes)

  query do
    import_fields :pet_owners_queries
    import_fields :pets_queries
  end

  mutation do
    import_fields :pets_mutations
    import_fields :pet_owners_mutations
    import_fields :accounts_mutations
    import_fields :auth_mutations
  end

end
