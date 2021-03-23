defmodule Parseroo.GeoText do
  use Parseroo.DataCase, async: true

  alias Parseroo.Geo

  describe "list_uf/1" do
    test "return a list of states" do
      assert Geo.list_uf() == [
               :AC,
               :AL,
               :AP,
               :AM,
               :BA,
               :CE,
               :DF,
               :ES,
               :EX,
               :GO,
               :MA,
               :MT,
               :MS,
               :MG,
               :PR,
               :PB,
               :PA,
               :PE,
               :PI,
               :RN,
               :RS,
               :RJ,
               :RO,
               :RR,
               :SC,
               :SE,
               :SP,
               :TO
             ]
    end
  end

  describe "get_uf_from_name/1" do
    test "return a uf abreviation from a name" do
      assert Geo.get_uf_from_name("São Paulo") == :SP
    end

    test "when uf is not found" do
      assert Geo.get_uf_from_name("inexistent") == nil
    end
  end
end
