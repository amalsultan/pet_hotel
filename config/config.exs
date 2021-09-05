# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pet_hotel,
  ecto_repos: [PetHotel.Repo]

# Configures the endpoint
config :pet_hotel, PetHotelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L+HEdUVFUiB0Gaf8nAPQ6dt47ejjKYRYluTmc1yNuSwpZgQyuEA9nuoMi2qpzm6y",
  render_errors: [view: PetHotelWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PetHotel.PubSub,
  live_view: [signing_salt: "YjpNkuxm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pet_hotel, PetHotel.Vault,
  ciphers: [
    # In AES.GCM, it is important to specify 12-byte IV length for
    # interoperability with other encryption software. See this GitHub issue
    # for more details: https://github.com/danielberkompas/cloak/issues/93
    #
    # In Cloak 2.0, this will be the default iv length for AES.GCM.
    default: {Cloak.Ciphers.AES.GCM, tag: "AES.GCM.V1", key: Base.decode64!("2/ldSrU5fw3Z1xQQtKlCbV2dLQ2TPJBTPeKnhoyoAZM="), iv_length: 12},
    aes_gcm: {Cloak.Ciphers.AES.GCM, tag: "AES.GCM.V1", key: Base.decode64!("2/ldSrU5fw3Z1xQQtKlCbV2dLQ2TPJBTPeKnhoyoAZM="), iv_length: 12},
    aes_ctr: {Cloak.Ciphers.AES.CTR, tag: "AES.CTR.V1", key: Base.decode64!("2/ldSrU5fw3Z1xQQtKlCbV2dLQ2TPJBTPeKnhoyoAZM=")}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
