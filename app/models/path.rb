class Path < ActiveRecord::Base
	belongs_to :line
	has_many :stations, :through => :stops
	has_many :stops
	has_many :reservations

	def self.findPaths(query)
		@paths = nil
		@lines = Line.all
		@s1 = Station.find(query[:station_first])
		@s2 = Station.find(query[:station_last])

		cs1 = Connection.where("first_station_id = (?)",query[:station_first])
		cs2 = Connection.where("first_station_id = (?)",query[:station_last])
		

	if !cs1.empty? && cs2.empty? 
		@dir = 1;
	elsif !cs2.empty? && cs1.empty?
		@dir = 2
	elsif cs2.empty? && cs1.empty?
        @dir = 0
	else

		if(cs1.size > 1) 
			c2 = cs2.first
			if cs1.first.line_id == c2.line_id
				c1 = cs1.first
			else
				c1 = cs1.last
			end
		else
			c1 = cs1.first
		end

		if(cs2.size > 1) 
			if cs2.first.line_id == c1.line_id
				c2 = cs2.first
			else
				c2 = cs2.last
			end
		else
			c2 = cs2.first
		end


		if(c1.order_num < c2.order_num)
			@dir = 1;
		else
			@dir = 2;
		end
	end

		@lines.each do |l|
			if l.stations.include?(@s1) && l.stations.include?(@s2)
				@paths = l.paths.where("direction = ?",@dir)
			end
		end
		@paths
	end

	def self.getDistance(coll)

		@sum = 0

		dir = coll.first.path.direction

		coll.each_with_index do |s, index|
			if index < (coll.size-1)
				if dir==1
					@sum = @sum +Connection.where("first_station_id = ? AND last_station_id = ?",s.station_id,coll[index+1].station_id).first.distance
				elsif dir==2
					@sum = @sum +Connection.where("first_station_id = ? AND last_station_id = ?",coll[index+1].station_id,s.station_id).first.distance
				end
			end
		end
		@sum

	end

end
