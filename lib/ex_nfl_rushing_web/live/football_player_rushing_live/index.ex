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
    player_name = params["player"]

    sort_by =
      case params["sort_by"] do
        sort_by when sort_by in ~w(yds td lng) ->
          params["sort_by"]

        _ ->
          "yds"
      end

    sort_order = (params["sort_order"] == "asc" && :asc) || :desc

    filtred_list = list_football_players_rushings(params)

    {:noreply,
     assign(socket,
       player: player_name,
       sort_by: sort_by,
       sort_order: sort_order,
       football_players_rushings: filtred_list
     )}
  end

  @impl true
  def handle_event("search", %{"player" => player_name} = params, socket) do
    filtred_list = list_football_players_rushings(params)

    {:noreply, assign(socket, player: player_name, football_players_rushings: filtred_list)}
  end

  def handle_event("sort", column, %{assigns: %{sort_by: sort_by, sort_order: :asc}} = socket)
      when column == sort_by do
    {:noreply, assign(socket, sort_by: sort_by, sort_order: :desc)}
  end

  def handle_event("sort", column, %{assigns: %{sort_by: sort_by, sort_order: :desc}} = socket)
      when column == sort_by do
    {:noreply, redirect_with_attrs(socket, sort_by: sort_by, sort_order: :asc)}
  end

  def handle_event("sort", column, socket) do
    {:noreply, redirect_with_attrs(socket, sort_by: column)}
  end

  defp redirect_with_attrs(socket, attrs) do
    player = attrs[:player] || socket.assigns[:player]
    sort_by = attrs[:sort_by] || socket.assigns[:sort_by]
    sort_order = attrs[:sort_order] || socket.assigns[:sort_order]

    football_players_rushings =
      attrs[:football_players_rushings] || socket.assigns[:football_players_rushings]

    push_patch(socket,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          football_players_rushings: football_players_rushings,
          player: player,
          sort_by: sort_by,
          sort_order: sort_order
        )
    )
  end

  defp list_football_players_rushings(params) do
    Statistic.list_football_players_rushings(params)
  end

  defp sort_order_icon(column, sort_by, :asc) when column == sort_by, do: "▲"
  defp sort_order_icon(column, sort_by, :desc) when column == sort_by, do: "▼"
  defp sort_order_icon(_, _, _), do: ""
end
