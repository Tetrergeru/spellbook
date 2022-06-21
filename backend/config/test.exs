import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :backend, Backend.Repo,
  username: System.get_env("TEST_POSTGRES_USER"),
  password: System.get_env("TEST_POSTGRES_PASSWORD"),
  hostname: System.get_env("TEST_POSTGRES_HOST"),
  database: System.get_env("TEST_POSTGRES_DB"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :backend, BackendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "hgX9pWpv4cV2Wqt6W8587lLsj1v6q41Y9wvPaEYw8N5KRO9iWia5uUQC3IXu0v+n",
  server: false

# In test we don't send emails.
config :backend, Backend.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
