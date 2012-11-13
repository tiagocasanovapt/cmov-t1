class Station < ActiveRecord::Base
	has_many :connections
	has_and_belongs_to_many :lines
	has_many :paths, :through => :stops
	has_many :stops
	has_many :reservations
end
