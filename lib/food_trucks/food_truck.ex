defmodule FoodTrucks.FoodTruck do
  @food_trucks_endpoint "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"


  def import_data do
    fetch_data()
    |> process_response()
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

  def process_response({:error, reason}), do: {:error, reason}

  def process_response(response) do
    response
    |> CSV.decode
    |> Enum.map(fn {:ok, data} -> data end)
    |> Enum.filter(fn
      ["locationid"|_] -> false
      _ -> true
    end)
  end
end
