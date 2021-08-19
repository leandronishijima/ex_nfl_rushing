defmodule NflRushing.Statistic.BuildFilters do
  import Ecto.Query, only: [from: 2]

  defguard is_asc?(order) when order == "asc"

  def player_filter(query, %{"player" => ""}), do: query

  def player_filter(query, %{"player" => player_name}) do
    player_name = "%#{player_name}%"

    from(f in query, where: ilike(f.player, ^player_name))
  end

  def player_filter(query, _), do: query

  def order_by(query, %{"sort_by" => ""}), do: query

  def order_by(query, %{"sort_by" => "yds", "sort_order" => order})
      when is_asc?(order) do
    from(f in query, order_by: f.yds)
  end

  def order_by(query, %{"sort_by" => "yds"}) do
    from(f in query, order_by: [desc: f.yds])
  end

  def order_by(query, %{"sort_by" => "lng", "sort_order" => order})
      when is_asc?(order) do
    from(f in query,
      order_by: fragment("NULLIF(regexp_replace(?, '\D', '', 'g'), '')::int", f.lng)
    )
  end

  def order_by(query, %{"sort_by" => "lng"}) do
    from(f in query,
      order_by: fragment("NULLIF(regexp_replace(?, '\D', '', 'g'), '')::int DESC", f.lng)
    )
  end

  def order_by(query, %{"sort_by" => "td", "sort_order" => order})
      when is_asc?(order) do
    from(f in query, order_by: f.td)
  end

  def order_by(query, %{"sort_by" => "td"}) do
    from(f in query, order_by: [desc: f.td])
  end

  def order_by(query, _params), do: query
end
