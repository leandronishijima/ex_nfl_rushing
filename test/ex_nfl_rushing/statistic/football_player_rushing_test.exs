defmodule NflRushing.Statistic.FootballPlayerRushingTest do
  use NflRushing.DataCase

  alias NflRushing.Statistic.FootballPlayerRushing

  test "attrs/0 return all attrs in order" do
    assert [
             "player",
             "team",
             "pos",
             "att/g",
             "att",
             "yds",
             "avg",
             "yds/g",
             "td",
             "lng",
             "1st",
             "1st%",
             "20+",
             "40+",
             "fum"
           ] == FootballPlayerRushing.attrs()
  end

  test "ordered_attrs/1" do
    struct = %FootballPlayerRushing{
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
    }

    assert [
             "Joe Banyard",
             "JAX",
             "RB",
             2,
             2,
             7,
             3.5,
             7,
             0,
             "7",
             0,
             0,
             0,
             0,
             0
           ] ==
             FootballPlayerRushing.ordered_attrs(struct)
  end
end
