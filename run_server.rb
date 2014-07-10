require 'yaml'
require 'active_record'
require 'socket'
require 'json'
require_relative 'lib/server'
require_relative 'lib/point'

# Declare Server
server = Server.new(8000)

# Establish connection with database
puts "Database initialized." if server.initialize_database

# Test database connection
puts "Database connection tested." if server.test

# Bind TCP Server to port 8000
server.establish_connection

# From here all logic is passed to lib/server.rb