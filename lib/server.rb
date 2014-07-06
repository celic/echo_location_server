# Gather input

# Get: Location (two ints), S/D (boolean), radius (int)

# If D, store in database

# Use haversine to find all other points in DB, within radius from given point

def initialize_database
	dbconfig = YAML::load(File.open('db/development-database.yml'))
	ActiveRecord::Base.establish_connection(dbconfig)
end

def establish_connection(port)
	server = TCPServer.new port
	loop do
		Thread.start(server.accept) do |client|
			
			# Parse JSON
			input = JSON.parse(client.gets)

			# Process state of user
			if input["state"].eql? 'D'

				# Save point in database
				@p = Point.create(lat: input["point"]["lat"], lon: input["point"]["lon"])
				puts 'Point added to database'

			elsif input["state"].eql? 'S'

				# Declare the point, but don't save it in the database
				@p = Point.new(lat: input["point"]["lat"], lon: input["point"]["lon"])
				puts 'Point not added to database'
			end

			puts @p.lat
			puts @p.lon

			client.close
		end
	end
end

def test
	# Create point
	@point = Point.create(lat: -40, lon: 120)

	puts @point.lat
end