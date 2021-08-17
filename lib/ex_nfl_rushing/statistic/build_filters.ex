defmodule NflRushing.Statistic.BuildFilters do
  import Ecto.Query, only: [from: 2]

  def player_filter(query, %{"player" => player_name}) do
    player_name = "%#{player_name}%"

    from(f in query,
      where: ilike(f.player, ^player_name)
    )
  end

  def player_filter(query, _params), do: query

  def order_by(query, %{"order_by" => ""}), do: query

  def order_by(query, %{"order_by" => "total_rushing_yards_asc"}) do
    from(f in query, order_by: f.yds)
  end

  def order_by(query, %{"order_by" => "total_rushing_yards_desc"}) do
    from(f in query, order_by: [desc: f.yds])
  end

  def order_by(query, %{"order_by" => "longest_rush_asc"}) do
    from(f in query, order_by: f.lng)
  end

  def order_by(query, %{"order_by" => "longest_rush_desc"}) do
    from(f in query, order_by: [desc: f.lng])
  end

  def order_by(query, %{"order_by" => "total_rushing_touchdowns_asc"}) do
    from(f in query, order_by: f.td)
  end

  def order_by(query, %{"order_by" => "total_rushing_touchdowns_desc"}) do
    from(f in query, order_by: [desc: f.td])
  end

  def order_by(query, _params), do: query
end
