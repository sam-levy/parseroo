defmodule Parseroo.Repo.Migrations.CreateStateTypeEnum do
  use Ecto.Migration

  import EctoEnumMigration

  def change do
    create_type(:state_type, [
      :AC,
      :AL,
      :AM,
      :AP,
      :BA,
      :CE,
      :DF,
      :ES,
      :GO,
      :MA,
      :MG,
      :MS,
      :MT,
      :PA,
      :PB,
      :PE,
      :PI,
      :PR,
      :RJ,
      :RN,
      :RO,
      :RR,
      :RS,
      :SC,
      :SE,
      :SP,
      :TO,
      :EX
    ])
  end
end
