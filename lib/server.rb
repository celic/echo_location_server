class Server

	def initialize(port)
		@port = port
	end

	def initialize_database
		dbconfig = YAML::load(File.open('db/development-database.yml'))
		ActiveRecord::Base.establish_connection(dbconfig)
		return true
	end

	def establish_connection
		server = TCPServer.new @port
		loop do

			puts "Server listening on port #{@port}."

			Thread.start(server.accept) do |client|

				puts "Client connected"
				
				if not parse_input(client.gets)
					puts "ERROR -- Invalid State"
					client.puts "ERROR -- Invalid State"
					client.close
				end

				puts "JSON parsed"

				puts "Recieved point: "
				puts @p.lat
				puts @p.lon

				puts haversine @p, @distance

				client.close
			end
		end
	end

	def parse_input(input)
		# Parse JSON
		json_input = JSON.parse(input)

		# Lots of error checking =====================================

		# Check for the three expected keys
		keys = json_input.keys
		if keys.include?("point") and keys.include?("state") and keys.include?("distance")

			# Check for the two keys inside of point
			point_keys = json_input["point"].keys
			if point_keys.include?("lat") and point_keys.include?("lon")
			else
				# Return false if lat and lon are not present
				return false
			end
		else
			# Return false if point, state and distance are not present
			return false
		end

		# Make sure there are only 3 keys
		return false unless keys.count.eql? 3

		@lat = json_input["point"]["lat"]
		@lon = json_input["point"]["lon"]
		@state = json_input["state"]
		@distance = json_input["distance"]

		# Make sure latitude is valid
		return false unless @lat.is_a? Numeric
		return false unless @lat >= -90 and @lat <= 90

		# Make sure longitude is valid
		return false unless @lon.is_a? Numeric
		return false unless @lon >= -180 and @lon <= 180

		# Make sure the state is valid
		return false unless @state.eql? 'S' or @state.eql? 'D'

		# Make sure the distance is valid
		return false unless @distance.is_a? Numeric
		return false unless @distance > 0 and @distance < 50

		# Done error checking ========================================

		# Process state of user
		if @state.eql? 'D'

			# Save point in database
			@p = Point.create(lat: @lat, lon: @lon)

		elsif @state.eql? 'S'

			# Declare the point, but don't save it in the database
			@p = Point.new(lat: @lat, lon: @lon)

		else
			return false
		end

		# Everything checks out
		return true
	end

	def haversine(point, distance)
		list = Array.new

		puts "Calculate distance for point: "
		puts point.to_json

		Point.all.each do |p|
			if not p.id == point.id
				dist = Haversine.distance(point.location, p.location)
				puts "Distance calculated"
				list << p if dist.to_mi <= distance
			end
		end

		puts "Points added"

		json = "{ points: [ "
		list.each do |p|
			json += p.to_json
		end
		json += " ] }"

		return json
	end

	def test
		# Create point
		@point = Point.create(lat: -40, lon: 120)

		# Test output
		# puts "Lat: #{@point.lat}"
		# puts "Lon: #{@point.lon}"

		return (not @point.nil?)
	end
end