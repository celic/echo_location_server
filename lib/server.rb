# Gather input
require 'yaml'
require 'active_record'

# Get: Location (two ints), S/D (boolean), radius (int)

# If D, store in database

# Use haversine to find all other points in DB, within radius from given point

dbconfig = YAML::load(File.open('db/development-database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)

# Create point
@point = Point.create(lat: -40, lon: 120)

puts @point.lat
