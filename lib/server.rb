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
			client.puts "Hello!"
			client.close
		end
	end
end

def test
	# Create point
	@point = Point.create(lat: -40, lon: 120)

	puts @point.lat
end