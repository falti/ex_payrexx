defmodule ExPayrexx do
  use Tesla
  adapter(Tesla.Adapter.Mint)

  plug(Tesla.Middleware.BaseUrl, Application.get_env(:ex_payrexx, :base_url))
  plug(Tesla.Middleware.Query, instance: Application.get_env(:ex_payrexx, :application))
  plug(ExPayrexx.AuthMiddleware)
  plug(Tesla.Middleware.FormUrlencoded)

  alias ExPayrexx.Request.{Invoice}

  def signature_check() do
    get("/SignatureCheck/") |> process_response()
  end

  def payment_provider() do
    get("/PaymentProvider/") |> process_response()
  end

  def create_payment_link(invoice) do
    post("/Invoice/", invoice) |> process_response()
  end

  def delete_payment_link(invoice_id) do
    delete("/Invoice/#{invoice_id}") |> process_response()
  end

  def retrieve_payment_link(invoice_id) do
    get("/Invoice/#{invoice_id}") |> process_response()
  end

  defp process_response(resp) do
    with {:ok, response} <- resp,
         {:ok, response_body} <- process_response_based_on_status_code(response),
         {:ok, body} <- process_payload(response_body),
         {:ok, data} <- validate_payload(body),
         do: {:ok, data}
  end

  defp process_response_based_on_status_code(response) do
    case response.status do
      200 -> {:ok, response.body}
      status -> {:error, status}
    end
  end

  defp process_payload(body) do
    body |> Jason.decode()
  end

  defp validate_payload(body) do
    case body["status"] do
      "success" -> {:ok, body["data"]}
      "error" -> {:error, body["message"]}
    end
  end
end
