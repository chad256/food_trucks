defmodule FoodTrucks.FoodTruckTest do
  use FoodTrucks.DataCase

  test "parse response from csv into lists of row data" do
    [first_truck | _] =
      mock_data()
      |> FoodTrucks.parse_response()

    assert first_truck == first_truck_list_mock()
  end

  test "create maps of food truck data" do
    [first_truck | _] =
      mock_data()
      |> FoodTrucks.parse_response()
      |> FoodTrucks.process_data()

    assert first_truck == first_truck_map_mock()
  end

  test "insert food trucks into database" do
    [{:ok, first_truck} | _] =
      mock_data()
      |> FoodTrucks.parse_response()
      |> FoodTrucks.process_data()
      |> FoodTrucks.save_data()

    assert %FoodTrucks.FoodTruck{id: _, address: "3750 18TH ST", applicant: "The Geez Freeze", approved: ~U[2022-01-28 20:00:00Z], block: 3579, blocklot: 3579006, cnn: 887000, dayshours: nil, expiration_date: ~U[2022-11-15 20:00:00Z], facility_type: "Truck", fire_prevention_districts: "8", food_items: "Snow Cones: Soft Serve Ice Cream & Frozen Virgin Daiquiris", latitude: _, location: "(37.76201920035647, -122.42730642251331)", location_description: "18TH ST: DOLORES ST to CHURCH ST (3700 - 3799)", location_id: 1571753, longitude: _, lot: 6, neighborhoods: "3", noisent: nil, permit: "21MFF-00015", police_districts: "4", prior_permit: 0, received: "20210315", schedule: "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00015&ExportPDF=1&Filename=21MFF-00015_schedule.pdf", status: "APPROVED", supervisor_districts: "5", x: _, y: _, zip_codes: 28862} = first_truck
  end


  def mock_data() do
    File.stream!("test/support/mobile_food_facility_permit.csv")
  end

  def first_truck_list_mock do
    ["1571753", "The Geez Freeze", "Truck", "887000",
   "18TH ST: DOLORES ST to CHURCH ST (3700 - 3799)", "3750 18TH ST", "3579006",
   "3579", "006", "21MFF-00015", "APPROVED",
   "Snow Cones: Soft Serve Ice Cream & Frozen Virgin Daiquiris", "6004575.869",
   "2105666.974", "37.76201920035647", "-122.42730642251331",
   "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00015&ExportPDF=1&Filename=21MFF-00015_schedule.pdf",
   "", "", "01/28/2022 12:00:00 AM", "20210315", "0", "11/15/2022 12:00:00 AM",
   "(37.76201920035647, -122.42730642251331)", "8", "4", "5", "28862", "3"]
  end

  def first_truck_map_mock do
    %{address: "3750 18TH ST", applicant: "The Geez Freeze", approved:  %DateTime{year: 2022, month: 1, day: 28, hour: 12, minute: 0, second: 0, time_zone: "Pacific", zone_abbr: "PST", utc_offset: -28800, std_offset: 0}, block: "3579", blocklot: "3579006", cnn: "887000", dayshours: "", expiration_date: %DateTime{year: 2022, month: 11, day: 15, hour: 12, minute: 0, second: 0, time_zone: "Pacific", zone_abbr: "PST", utc_offset: -28800, std_offset: 0}, facility_type: "Truck", fire_prevention_districts: "8", food_items: "Snow Cones: Soft Serve Ice Cream & Frozen Virgin Daiquiris", latitude: "37.76201920035647", location: "(37.76201920035647, -122.42730642251331)", location_description: "18TH ST: DOLORES ST to CHURCH ST (3700 - 3799)", location_id: "1571753", longitude: "-122.42730642251331", lot: "006", neighborhoods: "3", noisent: "", permit: "21MFF-00015", police_districts: "4", prior_permit: "0", received: "20210315", schedule: "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00015&ExportPDF=1&Filename=21MFF-00015_schedule.pdf", status: "APPROVED", supervisor_districts: "5", x: "6004575.869", y: "2105666.974", zip_codes: "28862"}
  end

end
