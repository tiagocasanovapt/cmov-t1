class PathsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :find_user, :checkReservations

  respond_to :json

	def index
		if(params[:line_id]) 
			@paths = Line.find(params[:line_id]).paths.order("direction asc")
		else
			@paths = Path.all
		end

	   	render :json => @paths
	end

	def pathsSupervisor
		if !@logged_user.supervisor
			render :json => {"message"=>"You dont have permission to do this"}
		elsif(params[:station_id] && params[:time]) 
			@lines = Line.where("first_station_id = ?",params[:station_id])

			if !@lines.empty?
				@paths = @lines.first.paths.where("direction=1 AND start_time > ?",params[:time])
			else			
				@paths = Line.where("last_station_id = ?",params[:station_id]).first.paths.where("direction=2 AND start_time > ?",params[:time])
			end
			render :json=> @paths
		else
			render :json=>{"message"=>"Unknown"}
		end
	end

	def lines
		@lines = Line.all
	   	render :json => @lines, :include => [:stations]
	end

	def search
		@totalDist = 0
		if(params[:station_first] && params[:station_last]) 
			@paths = Path.findPaths(params)

			if !@paths.nil?
				@paths.each do |p|
					if @stops.nil?
						@stops = [p.stops.where("station_id IN (?)",[params[:station_first],params[:station_last]])]
						@filt_stops = Stop.getStopsBetweenStations(p.stops,params)
						@totalDist += Path.getDistance(@filt_stops)
					else
						@stops.append(p.stops.where("station_id IN (?)",[params[:station_first],params[:station_last]]))
					end
				end
				render :json=>{"stops"=>@stops, "preco"=>@totalDist*Price.first[:price]}
			else
				middle = 9
				@paths1 = Path.findPaths({:station_first =>params[:station_first], :station_last=>middle })
				@paths2 = Path.findPaths({:station_first=>middle, :station_last=>params[:station_last] })

				@paths1.each do |p|
					if @stops.nil?
						@stops = [p.stops.where("station_id IN (?)",[params[:station_first],middle])]
						@filt_stops = Stop.getStopsBetweenStations(p.stops,{:station_first =>params[:station_first], :station_last=>middle })
						@totalDist += Path.getDistance(@filt_stops)
					else
						@stops.append(p.stops.where("station_id IN (?)",[params[:station_first],middle]))
					end
				end

				i=0
				@paths2.each do |p|
					if @stops.nil?
						@stops = [p.stops.where("station_id IN (?)",[middle,params[:station_last]])]
					else
						if i==0 then
							@filt_stops = Stop.getStopsBetweenStations(p.stops,{:station_first=>middle, :station_last=>params[:station_last] })
							@totalDist += Path.getDistance(@filt_stops)
							i=1
						end
						@stops.append(p.stops.where("station_id IN (?)",[middle,params[:station_last]]))
						
					end
				end
				render :json=>{"stops"=>@stops, "preco"=>@totalDist*Price.first[:price]}
			end

		end
	end

	def stopsPath
		@lines = Line.all
		@totalDist = 0

		if(params[:station_first] && params[:station_last]) 
			@s1 = Station.find(params[:station_first])
			@s2 = Station.find(params[:station_last])

			@c1 = Connection.where("first_station_id = (?)",params[:station_first]).first
			@c2 = Connection.where("first_station_id = (?)",params[:station_last]).first
			
			if(!@c1.nil? && (@c2.nil? || @c1.order_num < @c2.order_num))
				@dir = 1;
			else
				@dir = 2;
			end

			@lines.each do |l|
				if l.stations.include?(@s1) && l.stations.include?(@s2)
					@paths = l.paths.where("direction = (?)",@dir)
				end
			end

			@paths.each do |p|
				if @stops.nil?
					@stops = [stops_temp = p.stops.where("station_id IN (?)",[params[:station_first],params[:station_last]])]
					@filt_stops = Stop.getStopsBetweenStations(p.stops,params)
					@totalDist += Path.getDistance(@filt_stops)
				else
					@stops.append(p.stops.where("station_id IN (?)",[params[:station_first],params[:station_last]]))
				end
			end
		end

		render :json => {"stops"=>@stops, "preco"=>@totalDist*Price.first[:price]}
	end

	def connections

		@connections = Connection.where("line_id = ?", params[:id])

		render :json => @connections, :include => [:first_station, :last_station]
	end

end
