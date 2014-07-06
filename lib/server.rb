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

			@p = ''

			# Process state of user
			if input[state] == "D"
				# Save point in database
				@p = Point.create(input[point][lat], input[point][lon])

			elsif input[state] == "S"
				# Declare the point, but don't save it in the databse
				@p = Point.new(input[point][lat], input[point][lon])
			end

			client.close
		end
	end
end

def test
	# Create point
	@point = Point.create(lat: -40, lon: 120)

	puts @point.lat
end