defmodule NflRushingWeb.FootballPlayerRushingController do
  use NflRushingWeb, :controller

  alias NflRushing.Statistic

  def export_results(conn, params) do
    send_download(
      conn,
      {:binary, Statistic.export_csv(params)},
      content_type: "application/csv",
      filename: "export.csv"
    )
  end
end
