#! /bin/bash

set -e

# Ensure the app's dependencies are installed
mix deps.get

# set up the database
mix ecto.create
mix ecto.migrate

echo "Launching Phoenix web server..."
mix phx.server

