# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PetHotel.Repo.insert!(%PetHotel.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PetHotel.Pets.Pet
alias PetHotel.Repo

%Pet{name: "Tom", pet_owner_id: 1, type: "Dog", breed: "Husky"} |> Repo.insert!
%Pet{name: "Pera", pet_owner_id: 2, type: "Cat", breed: "Russian"} |> Repo.insert!
