defmodule ExPayrexx.Request.Invoice do
  defstruct title: nil,
            description: nil,
            psp: nil,
            referenceId: nil,
            purpose: nil,
            amount: nil,
            vatRate: nil,
            currency: nil,
            sku: nil,
            preAuthorization: nil,
            reservation: nil

  use ExConstructor
end
