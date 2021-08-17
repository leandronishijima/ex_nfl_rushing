# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias NflRushing.Statistic.FootballPlayerRushing
alias NflRushing.Repo

treat_yds_field = fn json ->
  if is_binary(json["yds"]) do
    %{json | "yds" => json["yds"] |> String.replace(",", "") |> String.to_integer()}
  else
    json
  end
end

treat_lng_field = fn json ->
  if not is_binary(json["lng"]) do
    %{json | "lng" => json["lng"] |> Integer.to_string()}
  else
    json
  end
end

to_insert =
  File.read!("./rushing.json")
  |> Jason.decode!()
  |> Enum.map(fn statistic ->
    json =
      for {key, val} <- statistic,
          into: %{},
          do: {String.downcase(key), val}

    json =
      json
      |> treat_yds_field.()
      |> treat_lng_field.()

    FootballPlayerRushing.changeset(%FootballPlayerRushing{}, json)
  end)

Repo.transaction(fn ->
  Enum.each(to_insert, &Repo.insert!(&1, []))
end)
