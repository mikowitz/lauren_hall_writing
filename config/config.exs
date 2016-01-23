# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :lauren_hall_writing, LaurenHallWriting.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "BwUN97raH0oLJK93CTobVrZcS1SiYkusXBUKK5nRj4jG4QRlkH28OMR9/UrXUvZf",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: LaurenHallWriting.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :template_engines, haml: PhoenixHaml.Engine

config :lauren_hall_writing, mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key: System.get_env("MAILGUN_API_KEY")
