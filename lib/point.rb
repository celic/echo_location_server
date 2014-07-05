require 'active_record'

class Point < ActiveRecord::Base

	# Validations
	validates :lat, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
	validates :lon, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
end