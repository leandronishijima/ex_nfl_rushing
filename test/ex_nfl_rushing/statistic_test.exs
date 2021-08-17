defmodule NflRushing.StatisticTest do
  use NflRushing.DataCase

  alias NflRushing.Statistic

  describe "football_players_rushings" do
    alias NflRushing.Statistic.FootballPlayerRushing

    @valid_attrs %{"1st": 42, "1st%": 42, "20+": 42, "40+": 42, att: 42, "att/g": 42, avg: "120.5", fum: 42, lng: "some lng", player: "some player", pos: "some pos", td: 42, team: "some team", yds: 42, "yds/g": 42}
    @update_attrs %{"1st": 43, "1st%": 43, "20+": 43, "40+": 43, att: 43, "att/g": 43, avg: "456.7", fum: 43, lng: "some updated lng", player: "some updated player", pos: "some updated pos", td: 43, team: "some updated team", yds: 43, "yds/g": 43}
    @invalid_attrs %{"1st": nil, "1st%": nil, "20+": nil, "40+": nil, att: nil, "att/g": nil, avg: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, yds: nil, "yds/g": nil}

    def football_player_rushing_fixture(attrs \\ %{}) do
      {:ok, football_player_rushing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistic.create_football_player_rushing()

      football_player_rushing
    end

    test "list_football_players_rushings/0 returns all football_players_rushings" do
      football_player_rushing = football_player_rushing_fixture()
      assert Statistic.list_football_players_rushings() == [football_player_rushing]
    end

    test "get_football_player_rushing!/1 returns the football_player_rushing with given id" do
      football_player_rushing = football_player_rushing_fixture()
      assert Statistic.get_football_player_rushing!(football_player_rushing.id) == football_player_rushing
    end

    test "create_football_player_rushing/1 with valid data creates a football_player_rushing" do
      assert {:ok, %FootballPlayerRushing{} = football_player_rushing} = Statistic.create_football_player_rushing(@valid_attrs)
      assert football_player_rushing.1st == 42
      assert football_player_rushing.1st% == 42
      assert football_player_rushing.20+ == 42
      assert football_player_rushing.40+ == 42
      assert football_player_rushing.att == 42
      assert football_player_rushing.att/g == 42
      assert football_player_rushing.avg == Decimal.new("120.5")
      assert football_player_rushing.fum == 42
      assert football_player_rushing.lng == "some lng"
      assert football_player_rushing.player == "some player"
      assert football_player_rushing.pos == "some pos"
      assert football_player_rushing.td == 42
      assert football_player_rushing.team == "some team"
      assert football_player_rushing.yds == 42
      assert football_player_rushing.yds/g == 42
    end

    test "create_football_player_rushing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistic.create_football_player_rushing(@invalid_attrs)
    end

    test "update_football_player_rushing/2 with valid data updates the football_player_rushing" do
      football_player_rushing = football_player_rushing_fixture()
      assert {:ok, %FootballPlayerRushing{} = football_player_rushing} = Statistic.update_football_player_rushing(football_player_rushing, @update_attrs)
      assert football_player_rushing.1st == 43
      assert football_player_rushing.1st% == 43
      assert football_player_rushing.20+ == 43
      assert football_player_rushing.40+ == 43
      assert football_player_rushing.att == 43
      assert football_player_rushing.att/g == 43
      assert football_player_rushing.avg == Decimal.new("456.7")
      assert football_player_rushing.fum == 43
      assert football_player_rushing.lng == "some updated lng"
      assert football_player_rushing.player == "some updated player"
      assert football_player_rushing.pos == "some updated pos"
      assert football_player_rushing.td == 43
      assert football_player_rushing.team == "some updated team"
      assert football_player_rushing.yds == 43
      assert football_player_rushing.yds/g == 43
    end

    test "update_football_player_rushing/2 with invalid data returns error changeset" do
      football_player_rushing = football_player_rushing_fixture()
      assert {:error, %Ecto.Changeset{}} = Statistic.update_football_player_rushing(football_player_rushing, @invalid_attrs)
      assert football_player_rushing == Statistic.get_football_player_rushing!(football_player_rushing.id)
    end

    test "delete_football_player_rushing/1 deletes the football_player_rushing" do
      football_player_rushing = football_player_rushing_fixture()
      assert {:ok, %FootballPlayerRushing{}} = Statistic.delete_football_player_rushing(football_player_rushing)
      assert_raise Ecto.NoResultsError, fn -> Statistic.get_football_player_rushing!(football_player_rushing.id) end
    end

    test "change_football_player_rushing/1 returns a football_player_rushing changeset" do
      football_player_rushing = football_player_rushing_fixture()
      assert %Ecto.Changeset{} = Statistic.change_football_player_rushing(football_player_rushing)
    end
  end
end
