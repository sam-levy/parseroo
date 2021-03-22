defmodule Parseroo.RecruitmentApp.LocalAdapter do
  @behaviour Parseroo.RecruitmentApp.Adapter

  alias Parseroo.Orders.Order

  @impl true
  def post_order(%Order{}) do
    {:ok,
     %{
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
     }}
  end
end
