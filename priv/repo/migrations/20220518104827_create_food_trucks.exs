defmodule FoodTrucks.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks) do
      add :location_id, :integer
      add :applicant, :string
      add :facility_type, :string
      add :cnn, :integer
      add :location_description, :string
      add :address, :string
      add :blocklot, :integer
      add :block, :integer
      add :lot, :integer
      add :permit, :string
      add :status, :string
      add :food_items, :text
      add :x, :decimal
      add :y, :decimal
      add :latitude, :decimal
      add :longitude, :decimal
      add :schedule, :string
      add :dayshours, :string
      add :noisent, :string
      add :approved, :utc_datetime
      add :received, :string
      add :prior_permit, :integer
      add :expiration_date, :utc_datetime
      add :location, :string
      add :fire_prevention_districts, :string
      add :police_districts, :string
      add :supervisor_districts, :string
      add :zip_codes, :integer
      add :neighborhoods, :string
    end

    create unique_index(:food_trucks, [:location_id, :applicant, :permit], name: :unique_applicant_at_location)
  end
end
