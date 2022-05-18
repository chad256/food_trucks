defmodule FoodTrucks.FoodTruckTest do
  use FoodTrucks.DataCase

  alias FoodTrucks.FoodTruck


  test "process data from csv response" do
    [first_truck | _] =
      mock_data()
      |> FoodTruck.process_response()

    assert first_truck == first_truck_mock()
  end


  def mock_data() do
    File.stream!("test/support/mobile_food_facility_permit.csv")
  end

  def first_truck_mock do
    ["1571753", "The Geez Freeze", "Truck", "887000",
   "18TH ST: DOLORES ST to CHURCH ST (3700 - 3799)", "3750 18TH ST", "3579006",
   "3579", "006", "21MFF-00015", "APPROVED",
   "Snow Cones: Soft Serve Ice Cream & Frozen Virgin Daiquiris", "6004575.869",
   "2105666.974", "37.76201920035647", "-122.42730642251331",
   "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00015&ExportPDF=1&Filename=21MFF-00015_schedule.pdf",
   "", "", "01/28/2022 12:00:00 AM", "20210315", "0", "11/15/2022 12:00:00 AM",
   "(37.76201920035647, -122.42730642251331)", "8", "4", "5", "28862", "3"]
  end
end
