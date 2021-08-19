defmodule NflRushing.Statistic do
  @moduledoc """
  The Statistic context.
  """

  import Ecto.Query, warn: false
  alias NflRushing.Repo

  alias NflRushing.Statistic.{FootballPlayerRushing, BuildFilters}

  @doc """
  Returns the list of football_players_rushings.

  ## Examples

      iex> list_football_players_rushings()
      [%FootballPlayerRushing{}, ...]

  """
  def list_football_players_rushings(params) do
    params
    |> build_base_query()
    |> Repo.all()
  end

  def export_csv(params) do
    content =
      params
      |> build_base_query()
      |> Repo.all()

    [FootballPlayerRushing.attrs()]
    |> Enum.concat(
      content
      |> Enum.map(&FootballPlayerRushing.ordered_attrs/1)
    )
    |> NflRushing.SemiColonCsv.dump_to_iodata()
    |> to_string
  end

  defp build_base_query(params) do
    FootballPlayerRushing
    |> BuildFilters.player_filter(params)
    |> BuildFilters.order_by(params)
  end
end
