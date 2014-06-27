require 'active_record'

class Point < ActiveRecord::Base

	attr_accessor :point_lat, :point_lon

	# Validations
	validates :point_lat, presence: true, numericality: {greater_than: -90, less_than: 90}
	validates :point_lon, presence: true, numericality: {greater_than: -180, less_than: 180}

	def initialize(params)
		@point_lat = params[:lat]
		@point_lon = params[:lon]
	end
end