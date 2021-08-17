defmodule NflRushing.Repo.Migrations.CreateFootballPlayersRushings do
  use Ecto.Migration

  def change do
    create table(:football_players_rushings) do
      add :att, :integer
      add :"att/g", :decimal
      add :avg, :decimal
      add :"1st", :integer
      add :"1st%", :decimal
      add :"40+", :integer
      add :fum, :integer
      add :lng, :string
      add :player, :string
      add :pos, :string
      add :td, :integer
      add :team, :string
      add :"20+", :integer
      add :yds,:integer
      add :"yds/g", :decimal

      timestamps()
    end

  end
end
