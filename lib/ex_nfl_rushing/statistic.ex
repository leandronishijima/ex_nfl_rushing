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
  def list_football_players_rushings do
    Repo.all(FootballPlayerRushing)
  end

  def export_csv(params) do
    content =
      params
      |> build_base_query()
      |> Repo.all()

    [FootballPlayerRushing.attrs()]
    |> Stream.concat(
      content
      |> Stream.map(&FootballPlayerRushing.ordered_attrs/1)
    )
    |> NflRushing.SemiColonCsv.dump_to_iodata()
    |> to_string
  end

  defp build_base_query(params) do
    FootballPlayerRushing
    |> BuildFilters.player_filter(params)
    |> BuildFilters.order_by(params)
  end

  @doc """
  Gets a single football_player_rushing.

  Raises `Ecto.NoResultsError` if the Football player rushing does not exist.

  ## Examples

      iex> get_football_player_rushing!(123)
      %FootballPlayerRushing{}

      iex> get_football_player_rushing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_football_player_rushing!(id), do: Repo.get!(FootballPlayerRushing, id)

  @doc """
  Creates a football_player_rushing.

  ## Examples

      iex> create_football_player_rushing(%{field: value})
      {:ok, %FootballPlayerRushing{}}

      iex> create_football_player_rushing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_football_player_rushing(attrs \\ %{}) do
    %FootballPlayerRushing{}
    |> FootballPlayerRushing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a football_player_rushing.

  ## Examples

      iex> update_football_player_rushing(football_player_rushing, %{field: new_value})
      {:ok, %FootballPlayerRushing{}}

      iex> update_football_player_rushing(football_player_rushing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_football_player_rushing(%FootballPlayerRushing{} = football_player_rushing, attrs) do
    football_player_rushing
    |> FootballPlayerRushing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a football_player_rushing.

  ## Examples

      iex> delete_football_player_rushing(football_player_rushing)
      {:ok, %FootballPlayerRushing{}}

      iex> delete_football_player_rushing(football_player_rushing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_football_player_rushing(%FootballPlayerRushing{} = football_player_rushing) do
    Repo.delete(football_player_rushing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking football_player_rushing changes.

  ## Examples

      iex> change_football_player_rushing(football_player_rushing)
      %Ecto.Changeset{data: %FootballPlayerRushing{}}

  """
  def change_football_player_rushing(
        %FootballPlayerRushing{} = football_player_rushing,
        attrs \\ %{}
      ) do
    FootballPlayerRushing.changeset(football_player_rushing, attrs)
  end
end
