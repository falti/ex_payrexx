defmodule ExPayrexxTest do
  use ExUnit.Case
  alias ExPayrexx.Request.{Invoice}

  test "signature check" do
    {:ok, result} = ExPayrexx.signature_check()
    assert Enum.count(result) > 0
    assert result == [%{"id" => 1}]
  end

  test "payment provider" do
    {:ok, result} = ExPayrexx.payment_provider()
    assert Enum.count(result) > 0

    Enum.each(result, fn e ->
      assert Map.has_key?(e, "activePaymentMethods")
      assert Map.has_key?(e, "id")
      assert Map.has_key?(e, "name")
      assert Map.has_key?(e, "paymentMethods")
    end)
  end

  test "invoice provider" do
    invoice = Invoice.new(%{title: "testinvoice", psp: 1, currency: "CHF", amount: 100})
    {:ok, result} = ExPayrexx.invoice(invoice)
    assert Enum.count(result) == 1
    invoice = Enum.at(result, 0)
    assert Map.has_key?(invoice, "amount")
    assert Map.has_key?(invoice, "api")
    assert Map.has_key?(invoice, "concardisOrderId")
    assert Map.has_key?(invoice, "createdAt")
    assert Map.has_key?(invoice, "currency")
    assert Map.has_key?(invoice, "description")
    assert Map.has_key?(invoice, "fields")

    assert invoice["amount"] == 100
    assert invoice["currency"] == "CHF"
  end
end
