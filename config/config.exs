use Mix.Config

config :ex_payrexx, 
  secret: System.get_env("PAYREXX_SECRET"),
  application: System.get_env("PAYREXX_APPLICATION"),
  base_url: "https://api.payrexx.com/v1.0"
config :tesla, adapter: Tesla.Adapter.Mint