defmodule Parceroo.Release do
  @moduledoc """
  Module containing release commands that can be used in production

  Since we don't have Mix, a build tool, inside releases, which are a production
  artifact, we need to bring said commands directly into the release.
  """
  @app :parseroo

  alias Ecto.Migrator

  @doc """
  Run application migrations

  Usage: $_build/prod/rel/parseroo/bin/parseroo eval "Parceroo.Release.migrate"
  """
  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} =
        Migrator.with_repo(
          repo,
          &Migrator.run(&1, :up, all: true)
        )
    end
  end

  @doc """
  Do rollback into application migrations

  Usage: $_build/prod/rel/parseroo/bin/parseroo eval "Parceroo.Release.rollback"
  """
  def rollback(repo, version) do
    load_app()

    {:ok, _, _} =
      Migrator.with_repo(
        repo,
        &Migrator.run(
          &1,
          :down,
          to: version
        )
      )
  end

  @doc """
  Run application seeds

  Usage: $_build/prod/rel/parseroo/bin/parseroo eval "Parceroo.Release.seed"
  """
  def seed do
    load_app()

    Enum.each(repos(), fn repo ->
      {:ok, _, _} = Migrator.with_repo(repo, &run_seeds_for/1)
    end)
  end

  defp run_seeds_for(repo) do
    seed_script = seeds_path(repo)

    if File.exists?(seed_script) do
      Code.eval_file(seed_script)
    end
  end

  defp seeds_path(repo) do
    repo.config()
    |> Keyword.fetch!(:otp_app)
    |> Application.app_dir("priv/repo/seeds.exs")
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
