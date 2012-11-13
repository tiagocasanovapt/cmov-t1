class Connection < ActiveRecord::Base
	belongs_to :first_station, :class_name => 'Station' 
	belongs_to :last_station, :class_name => 'Station'
	belongs_to :line
end
