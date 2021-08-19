defmodule NflRushingWeb.FootballPlayerRushingController do
  use NflRushingWeb, :controller

  alias NflRushing.Statistic

  def export_results(conn, params) do
    send_download(
      conn,
      {:binary, Statistic.export_csv(params)},
      content_type: "application/csv",
      filename: generate_file_name(params)
    )
  end

  defp generate_file_name(params) do
    Enum.join([
      DateTime.utc_now(),
      "_export_",
      Enum.map_join(params, "_", fn {key, val} -> ~s{#{key}_#{val}} end),
      ".csv"
    ])
  end
end
