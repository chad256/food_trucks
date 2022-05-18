defmodule FoodTrucks.Utilities do

  def to_datetime(raw_date) do
    case  String.split(raw_date, " ") do
      [date, time, meridiem] ->
        [month, day, year] =
          String.split(date, "/")

        [hour, minute, second] =
          time
          |> String.split(":")

        hour =
          case meridiem do
            "AM" -> String.to_integer(hour)
            "PM" -> String.to_integer(hour) + 12
          end

        %DateTime{year: String.to_integer(year), month: String.to_integer(month), day: String.to_integer(day), hour: hour, minute: String.to_integer(minute), second: String.to_integer(second), time_zone: "Pacific", zone_abbr: "PST", utc_offset: -28800, std_offset: 0}
      _ -> nil
    end

  end
end
