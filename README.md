# PetHotel

This application can be used as starter if you want to get started building an app with Phoenix, Elixir, GraphQL. This is a simple backend application to manage pets and pet owners data

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) from your browser.
# Extra Liberaries Used
      {:ex_doc, "~> 0.21"} #to generate documentation of code
      {:joken, "~> 2.2"}   #to generate JWT token for authentication
      {:cloak, "~> 1.1.1"} #to encrypt and decrypt password
# Sample QraphQL Queries
## SignUp
mutation{
  signUp(email: "amalsultan900@gmail.com", name: "Amal Sultan", password: "Cosmos786**", passwordConfirmation: "Cosmos786**"){
    id
    name
    email
  }
}
## SignIn
mutation {
  signIn(email: "amalsultan900@gmail.com", password: "Cosmos786**") {
    token
  }
}
## Pet Owner Queries
{
  petOwners{
    id
    name
  }
}

{ petOwners(page: 1, pageSize: 10){ id name} }

{
  getPetOwner(id: 1){
    name
    id
  }
}

## Pet Owner Mutations
mutation{
  createPetOwner(input: {name: "Saleha Maryam"}){
    id
    name
  }
}

mutation{
  updatePetOwner(input: {id: 9, name: "Saleha Maryam"}){
    id
    name
  }
}

mutation{
  deletePetOwner(id: 4)
}

## Pet Queries
{ allPets(page: 1, pageSize: 10, petOwnerId: 1){ id name} }

{ allPets(page: 1, pageSize: 10){ id name petOwnerId petOwnerName } }

{
  allPets(petOwnerId: 2){
    id
    name
    petOwnerId
    petOwnerName
  }
}

{
  getPet(id: 1){
    id
    name
    breed
  }
}

## Pet Mutations 
mutation {
  createPet(input: {id: 12, name: "Sasuke", breed: "Husky", type: "Dog", petOwnerId: 1}){
    id
    name
    petOwnerId
    breed
    type
  }
}

mutation {
  updatePet(input: {id: 12, name: "Sasuke", breed: "Russian", type: "Dog", petOwnerId: 1}){
    id
    name
    petOwnerId
    breed
    type
  }
}

mutation {
  deletePet(id: 12)
}

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
