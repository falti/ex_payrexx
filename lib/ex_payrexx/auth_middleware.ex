defmodule ExPayrexx.AuthMiddleware do
  @behaviour Tesla.Middleware

  @impl Tesla.Middleware
  def call(env, next, options) do
    env
    |> authorize(options)
    |> Tesla.run(next)
  end

  defp authorize(env, _opts) do
    body =
      case env.body do
        nil -> %{}
        _ -> Map.from_struct(env.body)
      end

    request_to_be_signed = URI.encode_query(body)
    sig = signature(request_to_be_signed)
    body_with_sigature = Map.merge(body, sig)

    env
    |> Map.put(:body, body_with_sigature)
  end

  defp signature(request_to_be_signed) do
    secret = Application.get_env(:ex_payrexx, :secret)
    signature = :crypto.mac(:hmac, :sha256, secret, request_to_be_signed) |> Base.encode64()
    %{ApiSignature: signature}
  end
end
