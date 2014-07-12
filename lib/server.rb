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
				


				if not parse_input(client.gets)
					puts "ERROR -- Invalid State"
					client.puts "ERROR -- Invalid State"
					client.close
				end

				puts @p.lat
				puts @p.lon

				client.close
			end
		end
	end

	def parse_input(input)
		# Parse JSON
		json_input = JSON.parse(input)

		# Process state of user
		if json_input["state"].eql? 'D'

			# Save point in database
			@p = Point.create(lat: json_input["point"]["lat"], lon: json_input["point"]["lon"])
			puts 'Point added to database'

		elsif json_input["state"].eql? 'S'

			# Declare the point, but don't save it in the database
			@p = Point.new(lat: json_input["point"]["lat"], lon: json_input["point"]["lon"])
			puts 'Point not added to database'
		else
			return false
		end

		return (not @p.nil?)
	end

	def search_points

	end

	def haversine

	end

	def test
		# Create point
		@point = Point.create(lat: -40, lon: 120)

		# Test output
		puts "Lat: #{@point.lat}"
		puts "Lon: #{@point.lon}"

		return (not @point.nil?)
	end
end