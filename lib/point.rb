require 'active_record'

class Point < ActiveRecord::Base

	# Validations
	validates :lat, presence: true, numericality: {greater_than: -90, less_than: 90}
	validates :lon, presence: true, numericality: {greater_than: -180, less_than: 180}
end