defmodule PetHotelWeb.Plugs.Context do
  @behaviour Plug

  alias PetHotel.Accounts.User
  alias PetHotel.Repo
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    put_private(conn, :absinthe, %{context: context})
  end

  defp build_context(conn) do
    %{}
    |> add_user_to_context(conn)
  end

  def present?(nil), do: false

  def present?(string) do
    string |> String.trim() |> String.length() > 0
  end

  defp add_user_to_context(%{} = context, conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         true <- present?(token),
         {:ok, user} <- get_user(token) do
      Map.put(context, :current_user, user)
    else
      _ -> context
    end
  end

  @spec get_user(String.t()) :: {:ok, User}
  defp get_user(token) do
    user = User |> Repo.get_by(access_token: token)
    {:ok, user}
  end
end
