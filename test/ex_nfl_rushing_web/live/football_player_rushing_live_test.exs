defmodule NflRushingWeb.FootballPlayerRushingLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NflRushing.Statistic

  @create_attrs %{
    "1st": 42,
    "1st%": 42,
    "20+": 42,
    "40+": 42,
    att: 42,
    "att/g": 42,
    avg: "120.5",
    fum: 42,
    lng: "some lng",
    player: "some player",
    pos: "some pos",
    td: 42,
    team: "some team",
    yds: 42,
    "yds/g": 42
  }

  defp fixture(:football_player_rushing) do
    {:ok, football_player_rushing} = Statistic.create_football_player_rushing(@create_attrs)
    football_player_rushing
  end

  defp create_football_player_rushing(_) do
    football_player_rushing = fixture(:football_player_rushing)
    %{football_player_rushing: football_player_rushing}
  end

  describe "Index" do
    setup [:create_football_player_rushing]

    test "lists all football_players_rushings", %{
      conn: conn,
      football_player_rushing: football_player_rushing
    } do
      {:ok, _index_live, html} =
        live(conn, Routes.football_player_rushing_index_path(conn, :index))

      assert html =~ "Listing Football players rushings"
      assert html =~ football_player_rushing.lng
    end
  end
end
