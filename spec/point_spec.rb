require "spec_helper"

describe Point do
	
	context "with normal input" do
		it "should accept positive numbers" do
			expect(Point.new(lat: 90, lon: 180).save).to be true
		end

		it "should accept negative numbers" do
			expect(Point.new(lat: -90, lon: -180).save).to be true
		end

		it "should accept decimals" do
			expect(Point.new(lat: 12.345, lon: 43.2198).save).to be true
		end
	end

	context "with positive numbers" do
		it "should reject large latitude" do
			expect(Point.new(lat: 91, lon: 0).save).to be false
		end

		it "should reject large longitude" do
			expect(Point.new(lat: 0, lon: 181).save).to be false
		end

		it "should reject large combinations" do
			expect(Point.new(lat: 91, lon: 181).save).to be false
		end
	end

	context "with negative numbers" do
		it "should reject small latitude" do
			expect(Point.new(lat: -91, lon: 0).save).to be false
		end

		it "should reject small longitude" do
			expect(Point.new(lat: 0, lon: -181).save).to be false
		end

		it "should reject small combinations" do
			expect(Point.new(lat: -91, lon: -181).save).to be false
		end
	end

	context "with irregular input" do
		it "should reject non-number latitude" do
			expect(Point.new(lat: 'a'*20, lon: 0).save).to be false
		end

		it "should reject non-number longitude" do
			expect(Point.new(lat: 0, lon: 'a'*20).save).to be false
		end

		it "should reject non-number combinations" do
			expect(Point.new(lat: 'a'*100, lon: 'a'*50).save).to be false
		end
	end
end