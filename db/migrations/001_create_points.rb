class CreatePoints < ActiveRecord::Migration
	def self.up
		create_table :points do |t|
			t.column :id, :int
			t.column :lat, :int
			t.column :lon, :int
		end
	end

	def self.down
		drop_table :points
	end
end