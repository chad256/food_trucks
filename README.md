# FoodTrucks

This Food Trucks application fetches data from the San Francisco food truck open data set and stores it in a Postgres database.

The FoodTrucks.DataImporter worker periodically makes requests to the endpoint to keep the database up to date.

If I had more time I would design an API to expose the data along with more robust testing.
