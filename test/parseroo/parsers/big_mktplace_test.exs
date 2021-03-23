defmodule Parseroo.Parsers.BigMktplaceTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.BigMktPlaceFactory
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
      payload = BigMktPlaceFactory.casted_payload()

      assert BigMktplace.parse(payload) == %OrderParams{
               address: %Address{
                 address_line: "Rua Fake de Testes 3454",
                 city: "Cidade de Testes",
                 complement: "teste",
                 country_code: "BR",
                 external_id: "1051695306",
                 latitude: "-23.629037",
                 longitude: "-46.712689",
                 neighborhood: "Vila de Testes",
                 receiver_phone: "41999999999",
                 state: "SP",
                 street_name: "Rua Fake de Testes",
                 street_number: "3454",
                 zip_code: "85045020"
               },
               buyer: %Buyer{
                 doc_number: "09487965477",
                 doc_type: "CPF",
                 email: "john@doe.com",
                 external_id: "136226073",
                 first_name: "John",
                 last_name: "Doe",
                 nickname: "JOHN DOE",
                 phone_number: "41999999999"
               },
               items: [
                 %Item{
                   external_id: "IT4801901403",
                   full_unit_price: 4990,
                   order_id: nil,
                   quantity: 1,
                   title: "Produto de Testes",
                   unit_price: 4990
                 }
               ],
               order: %Order{
                 buyer_id: nil,
                 date_closed: ~U[2019-06-24 20:45:35Z],
                 date_created: ~U[2019-06-24 20:45:32Z],
                 expiration_date: ~U[2019-07-22 20:45:35Z],
                 external_id: "9987071",
                 last_updated: ~U[2019-06-25 17:26:49Z],
                 paid_amount: 5504,
                 status: "paid",
                 store_id: 282,
                 total_amount: 4990,
                 total_amount_with_shipping: 5504,
                 total_shipping: 514
               },
               payments: [
                 %Payment{
                   date_approved: ~U[2019-06-24 20:45:35Z],
                   date_created: ~U[2019-06-24 20:45:33Z],
                   external_id: "12312313",
                   installment_amount: 5504,
                   installments: 1,
                   order_external_id: "9987071",
                   order_id: nil,
                   payer_external_id: "414138",
                   payment_type: "credit_card",
                   shipping_cost: 514,
                   status: "paid",
                   taxes_amount: 0,
                   total_paid_amount: 5504,
                   transaction_amount: 4990
                 }
               ],
               shipment: %Shipment{
                 date_created: ~U[2019-06-24 20:45:33Z],
                 external_id: "43444211797",
                 order_id: nil,
                 receiver_address_id: nil,
                 shipment_type: "shipping"
               }
             }
    end
  end
end
