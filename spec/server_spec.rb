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
			
			@good_input = '{ "point": { "lat": -40.2, "lon": 120.123 }, "state": "S", "distance": 1 }'
			@good_input2 = '{ "point": { "lat": 12, "lon": -120.123 }, "state": "D", "distance": 5 }'
			@good_input3 = '{ "point": { "lat": -80.2, "lon": -0.123 }, "state": "D", "distance": 40 }'
			@good_input4 = '{ "point": { "lat": 0.2, "lon": 1.123 }, "state": "D", "distance": 3 }'
			@good_input5 = '{ "point": { "lat": 10.2, "lon": -6.3 }, "state": "S", "distance": 3 }'
		
		end

		context "for regular input" do
			it "should return true" do
				expect(@server.parse_input(@good_input)).to be true
			end

			it "should create a valid point with matching latitude" do
				@server.parse_input(@good_input2)
				expect(Point.last.lat).to eq(JSON.parse(@good_input2)["point"]["lat"])
			end

			it "should create a valid point with matching longitude" do
				@server.parse_input(@good_input3)
				expect(Point.last.lon).to eq(JSON.parse(@good_input3)["point"]["lon"])
			end

			it "should add a point to the database if state is D" do
				@server.parse_input(@good_input4)
				expect(Point.last.lat).to eq(JSON.parse(@good_input4)["point"]["lat"])
				expect(Point.last.lon).to eq(JSON.parse(@good_input4)["point"]["lon"])
			end

			it "should not be in the database if the state is S" do
				@server.parse_input(@good_input5)
				expect(Point.last.lat).not_to eq(JSON.parse(@good_input5)["point"]["lat"])
				expect(Point.last.lon).not_to eq(JSON.parse(@good_input5)["point"]["lon"])
			end
		end

		context "for irregular input" do
			it "should reject if there are more than three attributes" do

			end

			it "should reject if there are less than three attributes" do

			end

			it "should reject if the three attibutes are not the expected three" do

			end

			it "should reject if the longitude is incorrect" do

			end

			it "should reject if the latitude is incorrect" do

			end

			it "should reject if both latitude and longitude are incorrect" do

			end

			it "should reject if the state is not S or D" do

			end

			it "should reject if the distance is a non number" do

			end

			it "should reject if the distance is not positive" do

			end

			it "should reject obnoxiously large distances" do

			end
		end
	end

	context "the search_points method" do

	end

	context "the haversine method" do


	end

	context "the test method" do
		it "should return true when the database is set up" do
			expect(@server.test).to be true
		end
	end
end