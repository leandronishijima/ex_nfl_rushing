defmodule NflRushingWeb.FootballPlayerRushingLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Statistic

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     assign(
       socket,
       football_players_rushings: list_football_players_rushings(params),
       sort_by: "yds",
       sort_order: :desc
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    sort_by =
      case params["sort_by"] do
        sort_by when sort_by in ~w(yds td lng) ->
          params["sort_by"]

        _ ->
          "yds"
      end

    sort_order = invert_sort_order(params["sort_order"])

    {:noreply,
     assign(socket,
       player: params["player"],
       sort_by: sort_by,
       sort_order: sort_order,
       football_players_rushings: list_football_players_rushings(params)
     )}
  end

  defp invert_sort_order(sort_order) when sort_order == :asc or sort_order == "asc", do: :desc
  defp invert_sort_order(sort_order) when sort_order == :desc or sort_order == "desc", do: :asc
  defp invert_sort_order(_), do: :desc

  @impl true
  def handle_event("search", %{"player" => player_name}, socket) do
    %{sort_by: sort_by, sort_order: sort_order} = socket.assigns

    params = %{"player" => player_name, "sort_by" => sort_by, "sort_order" => sort_order}

    {:noreply,
     assign(socket,
       player: player_name,
       football_players_rushings: list_football_players_rushings(params)
     )}
  end

  defp list_football_players_rushings(params),
    do: Statistic.list_football_players_rushings(params)

  defp sort_order_icon(column, sort_by, :asc) when column == sort_by, do: "▲"
  defp sort_order_icon(column, sort_by, :desc) when column == sort_by, do: "▼"
  defp sort_order_icon(_, _, _), do: ""
end
