# PetHotel

This application can be used as starter if you want to get started building an app with Phoenix, Elixir, GraphQL. This is a simple backend application to manage pets and pet owners data

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) from your browser.
# Sample QraphQL Queries
mutation{
  signUp(email: "amalsultan900@gmail.com", name: "Amal Sultan", password: "Cosmos786**", passwordConfirmation: "Cosmos786**"){
    id
    name
    email
  }
}

mutation {
  signIn(email: "amalsultan900@gmail.com", password: "Cosmos786**") {
    token
  }
}

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
