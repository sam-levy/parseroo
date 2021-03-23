defmodule Parseroo.RecruitmentApp.PostOrderWorkerTest do
  use Parseroo.DataCase, async: true

  import Mox

  alias Ecto.UUID
  alias Parseroo.RecruitmentApp.PostOrderWorker
  alias Parseroo.RecruitmentAppMock

  describe "perform/1" do
    test "when post succeeds" do
      buyer = insert(:buyer)
      order = insert(:order, buyer: buyer)
      address = insert(:address)

      insert(:item, order: order)
      insert(:payment, order: order)
      insert(:shipment, order: order, receiver_address: address)

      expect(RecruitmentAppMock, :post_order, fn _order_data ->
        {:ok, "success"}
      end)

      assert perform_job(PostOrderWorker, %{order_id: order.id}) == :ok
    end

    test "when post fails" do
      assert perform_job(PostOrderWorker, %{order_id: UUID.generate()}) == {:discard, :not_found}
    end
  end
end
