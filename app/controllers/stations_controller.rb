class StationsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :find_user, :checkReservations

  respond_to :json
	def index
		if(params[:station_id])
			@lines = Station.find(params[:station_id]).lines
			@lines.each do |l|
				if @stations.nil?
					@stations = l.stations
				else
					@l2 = l.stations
					@l2.each do |s|
						if !@stations.include?(s)
							@stations.append(s)
						end
					end
				end
			end
		else
			@stations = Station.all
		end

		render :json => @stations.sort! { |a,b| a.name.downcase <=> b.name.downcase }
	end

	def iniStations
		@lines = Line.all

		@lines.each do |l|
			if @stations.nil?
				@stations = Station.where("id =  ? or id= ?", l.first_station_id, l.last_station_id)
			else
				@sts = Station.where("id =  ? or id= ?", l.first_station_id, l.last_station_id)
				@sts.each do |s|
					@stations.append(s)
				end
			end
		end
		render :json => @stations.sort! { |a,b| a.name.downcase <=> b.name.downcase }

	end
end
