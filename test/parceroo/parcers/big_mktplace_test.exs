defmodule Parseroo.Parsers.BigMktplaceTest do
  use Parceroo.DataCase, async: true

  alias Parceroo.BigMktPlaceFactory
  alias Parseroo.Parsers.BigMktplace
  alias Parseroo.Parsers.Params.{Order, OrderParams}

  alias Parseroo.Parsers.Params.Order.{
    Address,
    Buyer,
    Item,
    Payment,
    Shipment
  }

  describe "parse/1" do
    test "parses an order" do
      payload = BigMktPlaceFactory.payload()

      assert BigMktplace.parse(payload) == %OrderParams{
               address: %Address{
                 address_line: "Rua Fake de Testes 3454",
                 city: "Cidade de Testes",
                 complement: "teste",
                 country_code: "BR",
                 external_id: 1_051_695_306,
                 latitude: "-23.629037",
                 longitude: "-46.712689",
                 neighborhood: "Vila de Testes",
                 receiver_phone: "41999999999",
                 state: "São Paulo",
                 street_name: "Rua Fake de Testes",
                 street_number: "3454",
                 zip_code: "85045020"
               },
               buyer: %Buyer{
                 doc_number: "09487965477",
                 doc_type: "CPF",
                 email: "john@doe.com",
                 external_id: 136_226_073,
                 first_name: "John",
                 last_name: "Doe",
                 nickname: "JOHN DOE",
                 phone_number: "41999999999"
               },
               items: [
                 %Item{
                   external_id: "IT4801901403",
                   full_unit_price: 49.9,
                   quantity: 1,
                   title: "Produto de Testes",
                   unit_price: 49.9
                 }
               ],
               order: %Order{
                 buyer_id: nil,
                 date_closed: "2019-06-24T16:45:35.000-04:00",
                 date_created: "2019-06-24T16:45:32.000-04:00",
                 expiration_date: "2019-07-22T16:45:35.000-04:00",
                 external_id: 9_987_071,
                 last_updated: "2019-06-25T13:26:49.000-04:00",
                 paid_amount: 55.04,
                 status: "paid",
                 store_id: 282,
                 total_amount: 49.9,
                 total_amount_with_shipping: 55.04,
                 total_shipping: 5.14
               },
               payments: [
                 %Payment{
                   date_approved: "2019-06-24T16:45:35.000-04:00",
                   date_created: "2019-06-24T16:45:33.000-04:00",
                   external_id: 12_312_313,
                   installment_amount: 55.04,
                   installments: 1,
                   order_external_id: nil,
                   order_id: 9_987_071,
                   payer_external_id: nil,
                   payment_type: "credit_card",
                   shipping_cost: 5.14,
                   status: "paid",
                   taxes_amount: 0,
                   total_paid_amount: 55.04,
                   transaction_amount: 49.9
                 }
               ],
               shipment: %Shipment{
                 date_created: "2019-06-24T16:45:33.000-04:00",
                 external_id: 43_444_211_797,
                 order_id: nil,
                 receiver_address_id: nil,
                 shipment_type: "shipping"
               }
             }
    end
  end
end
