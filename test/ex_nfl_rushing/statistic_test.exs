defmodule NflRushing.StatisticTest do
  use NflRushing.DataCase

  alias NflRushing.Repo
  alias NflRushing.Statistic
  alias NflRushing.Statistic.FootballPlayerRushing

  @csv_columns "player;team;pos;att/g;att;yds;avg;yds/g;td;lng;1st;1st%;20+;40+;fum\r\n"

  describe "statistic test" do
    setup :insert_statistics

    test "list_football_players_rushings/1 without params" do
      assert [
               %FootballPlayerRushing{player: "Joe Banyard"},
               %FootballPlayerRushing{player: "Joe Flacco"},
               %FootballPlayerRushing{player: "Shaun Hill"}
             ] = Statistic.list_football_players_rushings(%{})
    end

    test "list_football_players_rushings/1 when params have filter by player, sorting by yds (desc)" do
      assert [
               %FootballPlayerRushing{player: "Joe Flacco", yds: 58},
               %FootballPlayerRushing{player: "Joe Banyard", yds: 7}
             ] =
               Statistic.list_football_players_rushings(%{
                 "player" => "joe",
                 "sort_by" => "yds",
                 "sort_order" => "desc"
               })
    end

    test "list_football_players_rushings/1 when params sorting by lng (asc)" do
      assert [
               %FootballPlayerRushing{player: "Joe Banyard", lng: "7"},
               %FootballPlayerRushing{player: "Shaun Hill", lng: "9"},
               %FootballPlayerRushing{player: "Joe Flacco", lng: "16"}
             ] =
               Statistic.list_football_players_rushings(%{
                 "sort_by" => "lng",
                 "sort_order" => "asc"
               })
    end

    test "export_csv/1 when params have filter by player, sorting by yds (desc)" do
      assert @csv_columns <>
               "Joe Flacco;BAL;QB;2;2;58;3.5;7;0;16;0;0;0;0;0\r\n" <>
               "Joe Banyard;JAX;RB;2;2;7;3.5;7;0;7;0;0;0;0;0\r\n" ==
               Statistic.export_csv(%{
                 "player" => "joe",
                 "sort_by" => "yds",
                 "sort_order" => "desc"
               })
    end

    test "export_csv/1 when params have filter by player, sorting by yds (asc)" do
      assert @csv_columns <>
               "Joe Banyard;JAX;RB;2;2;7;3.5;7;0;7;0;0;0;0;0\r\n" <>
               "Joe Flacco;BAL;QB;2;2;58;3.5;7;0;16;0;0;0;0;0\r\n" ==
               Statistic.export_csv(%{
                 "player" => "joe",
                 "sort_by" => "yds",
                 "sort_order" => "asc"
               })
    end
  end

  defp insert_statistics(_) do
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
        td: 0,
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
        td: 0,
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
