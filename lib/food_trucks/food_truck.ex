defmodule FoodTrucks.FoodTruck do
  use Ecto.Schema
  alias FoodTrucks.FoodTruck

  @params [:location_id, :applicant, :facility_type, :cnn, :location_description, :address, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitude, :longitude, :schedule, :dayshours, :noisent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districts, :police_districts, :supervisor_districts, :zip_codes, :neighborhoods]

  schema "food_trucks" do
    field :location_id, :integer
    field :applicant, :string
    field :facility_type, :string
    field :cnn, :integer
    field :location_description, :string
    field :address, :string
    field :blocklot, :integer
    field :block, :integer
    field :lot, :integer
    field :permit, :string
    field :status, :string
    field :food_items, :string
    field :x, :decimal
    field :y, :decimal
    field :latitude, :decimal
    field :longitude, :decimal
    field :schedule, :string
    field :dayshours, :string
    field :noisent, :string
    field :approved, :utc_datetime
    field :received, :string
    field :prior_permit, :integer
    field :expiration_date, :utc_datetime
    field :location, :string
    field :fire_prevention_districts, :string
    field :police_districts, :string
    field :supervisor_districts, :string
    field :zip_codes, :integer
    field :neighborhoods, :string
  end

  def insert(params) do
    %FoodTruck{}
    |> changeset(params)
    |> FoodTrucks.Repo.insert()
  end

  def changeset(food_truck, params \\ %{}) do
    food_truck
    |> Ecto.Changeset.cast(params, @params)
    |> Ecto.Changeset.unique_constraint(:unique_applicant_at_location, name: :unique_applicant_at_location)
  end
end
