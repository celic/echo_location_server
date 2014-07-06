class ChangeLatAndLonToDecimals < ActiveRecord::Migration
	def self.up
		change_table :points do |t|
			t.change :lat, :decimal
			t.change :lon, :decimal
		end
	end

	def self.down
		change_table :points do |t|
			t.change :lat, :int
			t.change :lon, :int
		end
	end
end