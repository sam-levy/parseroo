defmodule Parseroo.Geo do
  @state_dict %{
    "Acre" => :AC,
    "Alagoas" => :AL,
    "Amapá" => :AP,
    "Amazonas" => :AM,
    "Bahia" => :BA,
    "Ceará" => :CE,
    "Distrito Federal" => :DF,
    "Espírito Santo" => :ES,
    "Goiás" => :GO,
    "Maranhão" => :MA,
    "Mato Grosso" => :MT,
    "Mato Grosso do Sul" => :MS,
    "Minas Gerais" => :MG,
    "Pará" => :PA,
    "Paraíba" => :PB,
    "Paraná" => :PR,
    "Pernambuco" => :PE,
    "Piauí" => :PI,
    "Rio de Janeiro" => :RJ,
    "Rio Grande do Norte" => :RN,
    "Rio Grande do Sul" => :RS,
    "Rondônia" => :RO,
    "Roraima" => :RR,
    "Santa Catarina" => :SC,
    "São Paulo" => :SP,
    "Sergipe" => :SE,
    "Tocantins" => :TO,
    "Exterior" => :EX
  }

  def list_uf do
    Enum.map(@state_dict, fn {_k, v} -> v end)
  end

  def get_uf_from_name(name) do
    Map.get(@state_dict, name)
  end
end

import EctoEnum

defenum(Parseroo.Geo.StateType, :state_type, Parseroo.Geo.list_uf())
