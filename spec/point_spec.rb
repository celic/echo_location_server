require "spec_helper"

describe Point do
	
	context "with normal input" do
		it "should accept positive numbers" do
			expect(Point.create(lat: 90, lon: 180)).to be true
		end

		it "should accept negative numbers" do
			expect(Point.create(lat: -90, lon: -180)).to be true
		end
	end

	context "with positive numbers" do
		it "should reject large latitude" do
			expect(Point.create(lat: 91, lon: 0)).to be false
		end

		it "should reject large longitude" do
			expect(Point.create(lat: 0, lon: 181)).to be false
		end

		it "should reject large combinations" do
			expect(Point.create(lat: 91, lon: 181)).to be false
		end
	end

	context "with negative numbers" do
		it "should reject small latitude" do
			expect(Point.create(lat: -91, lon: 0)).to be false
		end

		it "should reject small longitude" do
			expect(Point.create(lat: 0, lon: -181)).to be false
		end

		it "should reject small combinations" do
			expect(Point.create(lat: -91, lon: -181)).to be false
		end
	end

	context "with irregular input" do
		it "should reject non-number latitude" do
			expect(Point.create(lat: 'a'*20, lon: 0)).to be false
		end

		it "should reject non-number longitude" do
			expect(Point.create(lat: 0, lon: 'a'*20)).to be false
		end

		it "should reject non-number combinations" do
			expect(Point.create(lat: 'a'*100, lon: 'a'*50)).to be false
		end
	end
end