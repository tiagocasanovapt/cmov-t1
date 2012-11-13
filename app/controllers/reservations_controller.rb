class ReservationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :find_user, :checkReservations

 # respond_to :json

	def index
	   	@reservs = @logged_user.reservations
	    render :json => @reservs, :include => [:first_station, :last_station]
	end

	def create
		
	    @reserve = Reservation.new(params[:reservation])
	    @reserve.user = @logged_user;

        if @reserve.save
	       render json: @reserve, status: :created, location: @reserve 
        else
	       render json: @reserve.errors, status: :unprocessable_entity
	      end
	end

	def destroy
		@reserve = Reservation.find(params[:id])

		if @reserve.nil? || @reserve.user_id != @logged_user.id || @reserve.paid
		   render :status=>401, :json=>{:message=>"You can't destroy that reservation."}
	    else
	        @reserve.destroy
	        render :status=>200, :json=>{:message=>"OK"}
	    end
	end

	def payReservation
		@reserve = Reservation.find(params[:id])
		if !params[:id] || @reserve.nil? || @reserve.user_id != @logged_user.id || @reserve.paid
			render :status=>401, :json=>{:message=>"Invalid operation."}
		else
			@reserve.paid = true;
			@reserve.ticket = Base64.encode64(UUIDTools::UUID.random_create)[0..7]
			@reserve.save
			render :statues=>200, :json=>@reserve
		end
	end

	def getTickets
		if !@logged_user.supervisor
			render :json => {"message"=>"You dont have permission to do this"}
		elsif params[:id] && params[:date]
			@reservs = Reservation.where("path_id = ? AND reserv_date = ? AND paid = true",params[:id],params[:date])
			render :json => @reservs
		else
			render :json => {"message"=>"Unknown"}
		end
	end

	def ticket
		@reserve = Reservation.find(params[:id])
		@stop_first = Stop.where("station_id = ? and path_id = ?", @reserve.first_station_id, @reserve.path_id).first
		@stop_last = Stop.where("station_id = ? and path_id = ?", @reserve.last_station_id, @reserve.path_id).first
		if !params[:id] || @reserve.nil? || @reserve.user_id != @logged_user.id  || !@reserve.paid
			render :status=>401, :pdf=>{:message=>"Invalid operation."}
		end
	end

	def  updateVerified
		
		if !@logged_user.supervisor
			render :json => {"message"=>"You dont have permission to do this"}
		else
			params[:_json].each do |item|
				@r  = Reservation.find(item[:id])
				@r.verified=true
				@r.save
			end
		end

		render :status=>200, :json=>{:message=>"Success"}
	end

end


# Linhas com direcao oposta a station_id, no dia X, apos hora Y