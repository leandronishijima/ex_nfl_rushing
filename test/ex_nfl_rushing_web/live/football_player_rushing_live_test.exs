defmodule NflRushingWeb.FootballPlayerRushingLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NflRushing.{Repo, Statistic.FootballPlayerRushing}
  alias NflRushingWeb.FootballPlayerRushingLive.Index

  defp create_football_player_rushing(_) do
    joe_banyard =
      Repo.insert!(%FootballPlayerRushing{
        player: "Joe Banyard",
        team: "JAX",
        pos: "RB",
        att: 2,
        "att/g": 2,
        yds: 7,
        avg: 3.5,
        "yds/g": 7,
        td: 0,
        lng: "7",
        "1st": 0,
        "1st%": 0,
        "20+": 0,
        "40+": 0,
        fum: 0
      })

    joe_flacco =
      Repo.insert!(%FootballPlayerRushing{
        player: "Joe Flacco",
        team: "BAL",
        pos: "QB",
        att: 2,
        "att/g": 2,
        yds: 58,
        avg: 3.5,
        "yds/g": 7,
        td: 2,
        lng: "16",
        "1st": 0,
        "1st%": 0,
        "20+": 0,
        "40+": 0,
        fum: 0
      })

    shaun_hill =
      Repo.insert!(%FootballPlayerRushing{
        player: "Shaun Hill",
        team: "MIN",
        pos: "QB",
        att: 2,
        "att/g": 2,
        yds: 5,
        avg: 3.5,
        "yds/g": 7,
        td: 1,
        lng: "9",
        "1st": 0,
        "1st%": 0,
        "20+": 0,
        "40+": 0,
        fum: 0
      })

    {:ok, statistics: [joe_banyard, joe_flacco, shaun_hill]}
  end

  describe "Index" do
    setup [:create_football_player_rushing]

    test "lists all football_players_rushings", %{
      conn: conn,
      statistics: football_players_rushings
    } do
      {:ok, _index_live, html} = live(conn, Routes.live_path(conn, Index))

      assert html =~ "Listing Football players rushings"

      Enum.each(
        football_players_rushings,
        &assert(html =~ &1.player)
      )
    end

    test "lists all football_players_rushings with player filter", %{
      conn: conn,
      statistics: [joe_banyard, joe_flacco, shaun_hill]
    } do
      {:ok, index_live, _html} = live(conn, Routes.live_path(conn, Index))

      html =
        index_live
        |> element("form")
        |> render_change(%{player: "shaun"})

      assert html =~ "shaun"
      assert html =~ shaun_hill.player
      refute html =~ joe_banyard.player
      refute html =~ joe_flacco.player
    end

    test "lists all football_players_rushings with sort by yds", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_path(conn, Index))

      assert [
               {"tbody", [{"id", "football_players_rushings"}],
                [
                  {"tr", _,
                   [
                     {"td", _, ["Joe Flacco"]},
                     {"td", _, ["BAL"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["58"]} = _yds_flacco,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["2"]},
                     {"td", _, ["16"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Joe Banyard"]},
                     {"td", _, ["JAX"]},
                     {"td", _, ["RB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["7"]} = _yds_banyard,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Shaun Hill"]},
                     {"td", _, ["MIN"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["5"]} = _yds_hill,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["1"]},
                     {"td", _, ["9"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]}
                ]}
             ] =
               index_live
               |> element("#yds-sort")
               |> render_click()
               |> Floki.find("#football_players_rushings")

      assert_receive {_, {:patch, _, %{to: "/?player=&sort_by=yds&sort_order=desc"}}}
    end

    test "lists all football_players_rushings with sort by yds asc", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_path(conn, Index))

      index_live
      |> element("#yds-sort")
      |> render_click()

      assert_receive {_, {:patch, _, %{to: "/?player=&sort_by=yds&sort_order=desc"}}}

      assert [
               {"tbody", [{"id", "football_players_rushings"}],
                [
                  {"tr", _,
                   [
                     {"td", _, ["Shaun Hill"]},
                     {"td", _, ["MIN"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["5"]} = _yds_hill,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["1"]},
                     {"td", _, ["9"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Joe Banyard"]},
                     {"td", _, ["JAX"]},
                     {"td", _, ["RB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["7"]} = _yds_banyard,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Joe Flacco"]},
                     {"td", _, ["BAL"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["58"]} = _yds_flacco,
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["2"]},
                     {"td", _, ["16"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]}
                ]}
             ] =
               index_live
               |> element("#yds-sort")
               |> render_click()
               |> Floki.find("#football_players_rushings")

      assert_receive {_, {:patch, _, %{to: "/?player=&sort_by=yds&sort_order=asc"}}}
    end

    test "lists all football_players_rushings with sort by td", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_path(conn, Index))

      assert [
               {"tbody", [{"id", "football_players_rushings"}],
                [
                  {"tr", _,
                   [
                     {"td", _, ["Joe Flacco"]},
                     {"td", _, ["BAL"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["58"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["2"]},
                     {"td", _, ["16"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Shaun Hill"]},
                     {"td", _, ["MIN"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["5"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["1"]},
                     {"td", _, ["9"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Joe Banyard"]},
                     {"td", _, ["JAX"]},
                     {"td", _, ["RB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["7"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]}
                ]}
             ] =
               index_live
               |> element("#td-sort")
               |> render_click()
               |> Floki.find("#football_players_rushings")

      assert_receive {_, {:patch, _, %{to: "/?player=&sort_by=td&sort_order=desc"}}}
    end

    test "lists all football_players_rushings with sort by lng", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_path(conn, Index))

      assert [
               {"tbody", [{"id", "football_players_rushings"}],
                [
                  {"tr", _,
                   [
                     {"td", _, ["Joe Flacco"]},
                     {"td", _, ["BAL"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["58"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["2"]},
                     {"td", _, ["16"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Shaun Hill"]},
                     {"td", _, ["MIN"]},
                     {"td", _, ["QB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["5"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["1"]},
                     {"td", _, ["9"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]},
                  {"tr", _,
                   [
                     {"td", _, ["Joe Banyard"]},
                     {"td", _, ["JAX"]},
                     {"td", _, ["RB"]},
                     {"td", _, ["2"]},
                     {"td", _, ["2"]},
                     {"td", _, ["7"]},
                     {"td", _, ["3.5"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["7"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]},
                     {"td", _, ["0"]}
                   ]}
                ]}
             ] =
               index_live
               |> element("#lng-sort")
               |> render_click()
               |> Floki.find("#football_players_rushings")

      assert_receive {_, {:patch, _, %{to: "/?player=&sort_by=lng&sort_order=desc"}}}
    end
  end
end
