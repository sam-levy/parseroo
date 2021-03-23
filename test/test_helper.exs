ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Parseroo.Repo, :manual)

Mox.defmock(Parseroo.RecruitmentAppMock, for: Parseroo.RecruitmentApp.Adapter)
