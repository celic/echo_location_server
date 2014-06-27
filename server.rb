# Establish dependencies

# Gather input

# Get: Location (two ints), S/D (boolean), radius (int)

# If D, store in database

# Use GoogleMaps API to find all other points in DB, within radius from given point

ActiveRecord::Base.establish_connection(
	adapter: 'postgresql',
	host: 'localhost',
	database: 'points',
	user: 'chris',
	password: 'chris'
)

# Create point
point = Point.create(lat: -40, lon: 120)





# Database
# point_id --- point

# Point Class
# int lat
# int lon
# Handle bad input, return error from constructor in that case
