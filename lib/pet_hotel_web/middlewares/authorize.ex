defmodule PetHotelWeb.Middleware.Authorize do
  @behaviour Absinthe.Middleware
  alias PetHotel.Accounts.User

  def call(resolution, config) do
    case resolution.context do
      %{current_user: %User{}} ->
        resolution

      _ ->
        resolution |> Absinthe.Resolution.put_result({:error, :user_not_authenticated})
    end
  end
end
