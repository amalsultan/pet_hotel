defmodule PetHotel.Repo do
    @moduledoc false
  use Ecto.Repo,
    otp_app: :pet_hotel,
    adapter: Ecto.Adapters.Postgres
end
