require 'spec_helper'

describe Server do

	before do
		@server = Server.new(1234)
	end

	context "the initialize_database method" do
		it "should return true" do 
			expect(@server.initialize_database).to be true
		end
	end

	context "the parse_input method" do

		before do
			@server.initialize_database
		end

		context "with regular input" do
			it "should return true" do
				@input = '{ "point": { "lat": -40.2, "lon": 120.123 }, "state": "S", "distance": 1 }'
				expect(@server.parse_input(@input)).to be true
			end

			it "should create a valid point with matching latitude" do
				@input = '{ "point": { "lat": 12, "lon": -120.123 }, "state": "D", "distance": 5 }'
				@server.parse_input(@input)
				expect(Point.last.lat).to eq(JSON.parse(@input)["point"]["lat"])
			end

			it "should create a valid point with matching longitude" do
				@input = '{ "point": { "lat": -80.2, "lon": -0.123 }, "state": "D", "distance": 40 }'
				@server.parse_input(@input)
				expect(Point.last.lon).to eq(JSON.parse(@input)["point"]["lon"])
			end

			it "should add a point to the database if state is D" do
				@input = '{ "point": { "lat": 0.2, "lon": 1.123 }, "state": "D", "distance": 3 }'
				@server.parse_input(@input)
				expect(Point.last.lat).to eq(JSON.parse(@input)["point"]["lat"])
				expect(Point.last.lon).to eq(JSON.parse(@input)["point"]["lon"])
			end

			it "should not be in the database if the state is S" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": 3 }'
				@server.parse_input(@input)
				expect(Point.last.lat).not_to eq(JSON.parse(@input)["point"]["lat"])
				expect(Point.last.lon).not_to eq(JSON.parse(@input)["point"]["lon"])
			end
		end

		context "with irregular input" do
			it "should reject if there are more than three attributes" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": 3, "doctors": 13 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if there are less than three attributes" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S" }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the three attibutes are not the expected three" do
				@input = '{ "pacience": { "lat": 10.2, "lon": -6.3 }, "not": "S", "patience": 3 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the nested two attributes are not the expected two" do
				@input = '{ "point": { "andrew": 10.2, "cantspell": -6.3 }, "state": "S", "distance": 3 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the longitude is incorrect" do
				@input = '{ "point": { "lat": 12, "lon": 900 }, "state": "D", "distance": 12 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject non-number longitudes" do
				@input = '{ "point": { "lat": 10.2, "lon": "twelve" }, "state": "S", "distance": 3 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the latitude is incorrect" do
				@input = '{ "point": { "lat": -1200, "lon": -4 }, "state": "D", "distance": 12 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject non-number latitides" do
				@input = '{ "point": { "lat": "eleven", "lon": -6.3 }, "state": "S", "distance": 3 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if both latitude and longitude are incorrect" do
				@input = '{ "point": { "lat": 120, "lon": -181 }, "state": "D", "distance": 12 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the state is not S or D" do
				@input = '{ "point": { "lat": 120, "lon": -181 }, "state": "Q", "distance": 12 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the distance is a non number" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": "thirteen" }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject if the distance is not positive" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": -3 }'
				expect(@server.parse_input(@input)).to be false
			end

			it "should reject obnoxiously large distances" do
				@input = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": 9001 }'
				expect(@server.parse_input(@input)).to be false
			end
		end
	end

	context "the haversine method" do


	end

	context "the test method" do
		it "should return true when the database is set up" do
			expect(@server.test).to be true
		end
	end
end
