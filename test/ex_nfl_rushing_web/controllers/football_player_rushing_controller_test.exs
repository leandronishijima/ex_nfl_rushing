defmodule NflRushingWeb.FootballPlayerRushingControllerTest do
  use NflRushingWeb.ConnCase

  alias NflRushing.Repo
  alias NflRushing.Statistic.FootballPlayerRushing

  describe "export_results" do
    setup :create_football_player_rushing

    test "when only player name is sent", %{conn: conn} do
      %{query_params: query, resp_body: csv} =
        get(conn, Routes.football_player_rushing_path(conn, :export_results, player: "shaun"))

      assert %{"player" => "shaun"} == query

      assert "player;team;pos;att/g;att;yds;avg;yds/g;td;lng;1st;1st%;20+;40+;fum\r\nShaun Hill;MIN;QB;2;2;5;3.5;7;1;9;0;0;0;0;0\r\n" ==
               csv
    end

    test "when all parameters are passed", %{conn: conn} do
      %{query_params: query, resp_body: csv} =
        get(
          conn,
          Routes.football_player_rushing_path(conn, :export_results,
            player: "joe",
            sort_by: "yds",
            sort_order: "desc"
          )
        )

      assert %{"player" => "joe", "sort_by" => "yds", "sort_order" => "desc"} == query

      assert "player;team;pos;att/g;att;yds;avg;yds/g;td;lng;1st;1st%;20+;40+;fum\r\nJoe Flacco;BAL;QB;2;2;58;3.5;7;2;16;0;0;0;0;0\r\nJoe Banyard;JAX;RB;2;2;7;3.5;7;0;7;0;0;0;0;0\r\n" ==
               csv
    end
  end

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
end
