defmodule Parseroo.BigMktPlaceFactory do
  def payload do
    %{
      "buyer" => %{
        "billing_info" => %{"doc_number" => "09487965477", "doc_type" => "CPF"},
        "email" => "john@doe.com",
        "first_name" => "John",
        "id" => 136_226_073,
        "last_name" => "Doe",
        "nickname" => "JOHN DOE",
        "phone" => %{"area_code" => 41, "number" => "999999999"}
      },
      "date_closed" => "2019-06-24T16:45:35.000-04:00",
      "date_created" => "2019-06-24T16:45:32.000-04:00",
      "expiration_date" => "2019-07-22T16:45:35.000-04:00",
      "id" => 9_987_071,
      "last_updated" => "2019-06-25T13:26:49.000-04:00",
      "order_items" => [
        %{
          "full_unit_price" => 49.9,
          "item" => %{"id" => "IT4801901403", "title" => "Produto de Testes"},
          "quantity" => 1,
          "unit_price" => 49.9
        }
      ],
      "paid_amount" => 55.04,
      "payments" => [
        %{
          "date_approved" => "2019-06-24T16:45:35.000-04:00",
          "date_created" => "2019-06-24T16:45:33.000-04:00",
          "id" => 12_312_313,
          "installment_amount" => 55.04,
          "installments" => 1,
          "order_id" => 9_987_071,
          "payer_id" => 414_138,
          "payment_type" => "credit_card",
          "shipping_cost" => 5.14,
          "status" => "paid",
          "taxes_amount" => 0,
          "total_paid_amount" => 55.04,
          "transaction_amount" => 49.9
        }
      ],
      "shipping" => %{
        "date_created" => "2019-06-24T16:45:33.000-04:00",
        "id" => 43_444_211_797,
        "receiver_address" => %{
          "address_line" => "Rua Fake de Testes 3454",
          "city" => %{"name" => "Cidade de Testes"},
          "comment" => "teste",
          "country" => %{"id" => "BR", "name" => "Brasil"},
          "id" => 1_051_695_306,
          "latitude" => -23.629037,
          "longitude" => -46.712689,
          "neighborhood" => %{"id" => nil, "name" => "Vila de Testes"},
          "receiver_phone" => "41999999999",
          "state" => %{"name" => "São Paulo"},
          "street_name" => "Rua Fake de Testes",
          "street_number" => "3454",
          "zip_code" => "85045020"
        },
        "shipment_type" => "shipping"
      },
      "status" => "paid",
      "store_id" => 282,
      "total_amount" => 49.9,
      "total_amount_with_shipping" => 55.04,
      "total_shipping" => 5.14
    }
  end
end
