class StopsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :checkReservations, :find_user

  respond_to :json
	def index
		if params[:path_id] && params[:station_first] && params[:station_last]
			@path = Path.find(params[:path_id])

			@c1 = @path.stops.where("station_id = (?)",params[:station_first]).first
			@c2 = @path.stops.where("station_id = (?)",params[:station_last]).first
			@stops = @path.stops.where("stop_time >= (?) AND stop_time <= (?)",@c1.stop_time, @c2.stop_time)
		elsif params[:path_id]
			@stops = Path.find(params[:path_id]).stops.order("stop_time asc")
		else
			@stops = Stop.all
		end 	
		
		render :json => @stops, :include => [:station]
	end

end
