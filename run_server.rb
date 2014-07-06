require 'yaml'
require 'active_record'
require 'socket'
require_relative 'lib/server'
require_relative 'lib/point'

# Establish connection with database
initialize_database

# Test database connection
test

# Bind TCP Server to port 80
establish_connection 8000

# From here all logic is passed to lib/server.rb