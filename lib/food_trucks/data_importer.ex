defmodule FoodTrucks.DataImporter do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def init(state) do
    schedule_data_import(2000)
    {:ok, state}
  end

  def handle_info(:import_data, state) do
    FoodTrucks.import_data()
    schedule_data_import()
    {:noreply, state}
  end

  defp schedule_data_import(time) do
    Process.send_after(self(), :import_data, time)
  end

  defp schedule_data_import do
    Process.send_after(self(), :import_data, :timer.hours(12))
  end
end
