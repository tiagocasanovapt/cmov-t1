class Stop < ActiveRecord::Base
	belongs_to :path
  	belongs_to :station


  	def self.getStopsBetweenStations(stops, pars)
  		c1 = stops.where("station_id = (?)",pars[:station_first]).first
		c2 = stops.where("station_id = (?)",pars[:station_last]).first

		@filtered_stops = stops.where("stop_time >= (?) AND stop_time <= (?)",c1.stop_time, c2.stop_time)
  	end
end
