defmodule NflRushing.Statistic.FootballPlayerRushing do
  use Ecto.Schema
  import Ecto.Changeset

  @ordered_attrs ~w(
    player
    team
    pos
    att/g
    att
    yds
    avg
    yds/g
    td
    lng
    1st
    1st%
    20+
    40+
    fum
  )a

  schema "football_players_rushings" do
    field :att, :integer
    field :"att/g", :decimal
    field :avg, :decimal
    field :"1st", :integer
    field :"1st%", :decimal
    field :"40+", :integer
    field :fum, :integer
    field :lng, :string
    field :player, :string
    field :pos, :string
    field :td, :integer
    field :team, :string
    field :"20+", :integer
    field :yds, :integer
    field :"yds/g", :decimal

    timestamps()
  end

  def changeset(statistic, attrs) do
    statistic
    |> cast(attrs, @ordered_attrs)
    |> validate_required(@ordered_attrs)
  end

  def attrs, do: for(atom <- @ordered_attrs, into: [], do: Atom.to_string(atom))

  def ordered_attrs(struct = %__MODULE__{}), do: Enum.map(@ordered_attrs, &Map.get(struct, &1))
end
