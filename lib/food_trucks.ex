defmodule FoodTrucks do
  import FoodTrucks.Utilities, only: [to_datetime: 1]
  alias FoodTrucks.FoodTruck

  @food_trucks_endpoint "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"


  def import_data do
    fetch_data()
    |> parse_response()
    |> process_data()
    |> save_data()
  end

  def fetch_data do
    case HTTPoison.get(@food_trucks_endpoint) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not Found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def parse_response({:error, reason}), do: {:error, reason}

  def parse_response(response) when is_binary(response) do
    response
    |> StringIO.open()
    |> (fn {:ok, pid} -> pid end).()
    |> IO.binstream(:line)
    |> parse_response()
  end

  def parse_response(response) do
    response
    |> CSV.decode
    |> Enum.map(fn {:ok, data} -> data end)
    |> Enum.filter(fn
      ["locationid"|_] -> false
      _ -> true
    end)
  end

  def process_data(data) do
    data
    |> Enum.map(&process_data_maps(&1))
  end

  def process_data_maps(data) do
    [location_id,
      applicant,
      facility_type,
      cnn,
      location_description,
      address,
      blocklot,
      block,
      lot,
      permit,
      status,
      food_items,
      x,
      y,
      latitude,
      longitude,
      schedule,
      dayshours,
      noisent,
      approved,
      received,
      prior_permit,
      expiration_date,
      location,
      fire_prevention_districts,
      police_districts,
      supervisor_districts,
      zip_codes,
      neighborhoods] = data
    %{
      location_id: location_id,
      applicant: applicant,
      facility_type: facility_type,
      cnn: cnn,
      location_description: location_description,
      address: address,
      blocklot: blocklot,
      block: block,
      lot: lot,
      permit: permit,
      status: status,
      food_items: food_items,
      x: x,
      y: y,
      latitude: latitude,
      longitude: longitude,
      schedule: schedule,
      dayshours: dayshours,
      noisent: noisent,
      approved: to_datetime(approved),
      received: received,
      prior_permit: prior_permit,
      expiration_date: to_datetime(expiration_date),
      location: location,
      fire_prevention_districts: fire_prevention_districts,
      police_districts: police_districts,
      supervisor_districts: supervisor_districts,
      zip_codes: zip_codes,
      neighborhoods: neighborhoods
    }
  end

  def save_data(food_trucks) do
    food_trucks
    |> Enum.map(&FoodTruck.insert(&1))
  end
end
