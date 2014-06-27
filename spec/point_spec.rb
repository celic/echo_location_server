require_relative '../point'
require_relative '../server'

describe Point do

	before do


	end
	
	context "with normal input" do
		it "should accept positive numbers" do
			Point.create(lat: 90, lon: 180).should be_true
		end

		it "should accept negative numbers" do
			Point.create(lat: -90, lon: -180).should be_true
		end
	end

	context "with positive numbers" do
		it "should reject large latitude" do
			Point.create(lat: 91, lon: 0).should be_false
		end

		it "should reject large longitude" do
			Point.create(lat: 0, lon: 181).should be_false
		end

		it "should reject large combinations" do
			Point.create(lat: 91, lon: 181).should be_false
		end
	end

	context "with negative numbers" do
		it "should reject small latitude" do
			Point.create(lat: -91, lon: 0).should be_false
		end

		it "should reject small longitude" do
			Point.create(lat: 0, lon: -181).should be_false
		end

		it "should reject small combinations" do
			Point.create(lat: -91, lon: -181).should be_false
		end
	end

	context "with irregular input" do
		it "should reject non-number latitude" do
			Point.create(lat: 'a'*20, lon: 0).should be_false
		end

		it "should reject non-number longitude" do
			Point.create(lat: 0, lon: 'a'*20).should be_false
		end

		it "should reject non-number combinations" do
			Point.create(lat: 'a'*100, lon: 'a'*50).should be_false
		end
	end
end