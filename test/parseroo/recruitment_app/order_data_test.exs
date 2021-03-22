defmodule Parseroo.RecruitmentApp.OrderDataTest do
  use Parseroo.DataCase, async: true

  alias Parseroo.RecruitmentApp.OrderData
  alias Parseroo.RecruitmentApp.OrderData.{Customer, Item, Payment}
  alias Parseroo.Repo

  describe "build/1" do
    test "builds an OrderData sctruct" do
      buyer = insert(:buyer)
      order = insert(:order, buyer: buyer)
      address = insert(:address)

      insert(:item, order: order)
      insert(:payment, order: order)
      insert(:shipment, order: order, receiver_address: address)

      order = Repo.preload(order, [:items, :payments, :buyer, shipment: [:receiver_address]])

      assert %OrderData{} = order_data = OrderData.build(order)

      assert %Customer{} = order_data.customer
      assert [%Item{}] = order_data.items
      assert [%Payment{}] = order_data.payments
    end
  end

  describe "to_params/1" do
    test "converts struct to params" do
      order_data = %Parseroo.RecruitmentApp.OrderData{
        city: "Serra Janaína",
        complement: "Ratione libero maiores?",
        country: "BR",
        customer: %Parseroo.RecruitmentApp.OrderData.Customer{
          contact: "504/735-2188",
          email: "abigayle.yost@casper.name",
          external_code: "253",
          name: "Luigi Barton"
        },
        delivery_fee: 0.05,
        district: "Jardim Leblon",
        dt_order_create: "2021-03-20 06:38:27Z",
        external_code: "6506",
        items: [
          %Parseroo.RecruitmentApp.OrderData.Item{
            external_code: "6449",
            name: "Charjabug",
            price: 2.82,
            quantity: 3,
            sub_items: [],
            total: 2.82
          }
        ],
        latitude: -72.88842920115954,
        longitude: -130.34919077016775,
        number: "2410",
        payments: [
          %Parseroo.RecruitmentApp.OrderData.Payment{type: "boleto", value: 116.11}
        ],
        postal_code: "33.615-209",
        state: "CE",
        store_id: 6944,
        street: "Trecho Paes",
        sub_total: 80.25,
        total: 80.3
      }

      assert OrderData.to_params(order_data) == %{
               "city" => "Serra Janaína",
               "complement" => "Ratione libero maiores?",
               "country" => "BR",
               "customer" => %{
                 "contact" => "504/735-2188",
                 "email" => "abigayle.yost@casper.name",
                 "externalCode" => "253",
                 "name" => "Luigi Barton"
               },
               "deliveryFee" => 0.05,
               "district" => "Jardim Leblon",
               "dtOrderCreate" => "2021-03-20 06:38:27Z",
               "externalCode" => "6506",
               "items" => [
                 %{
                   "externalCode" => "6449",
                   "name" => "Charjabug",
                   "price" => 2.82,
                   "quantity" => 3,
                   "subItems" => [],
                   "total" => 2.82
                 }
               ],
               "latitude" => -72.88842920115954,
               "longitude" => -130.34919077016775,
               "number" => "2410",
               "payments" => [%{"type" => "boleto", "value" => 116.11}],
               "postalCode" => "33.615-209",
               "state" => "CE",
               "storeId" => 6944,
               "street" => "Trecho Paes",
               "subTotal" => 80.25,
               "total" => 80.3
             }
    end
  end
end
