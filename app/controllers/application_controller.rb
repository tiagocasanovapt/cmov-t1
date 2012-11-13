class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected    
    def find_user
      @logged_user=User.find_by_authentication_token(params[:auth_token])
      if @logged_user.nil? or params[:auth_token].nil?
        logger.info("Token not found.")
        render :status=>404, :json=>{:message=>"Invalid token."}
      end
    end

    def checkReservations
		reservs = Reservation.where("reserv_date >= ? AND paid = false",Date.today)

		reservs.each do |r|
			if r.reserv_date-24.hours < Time.now
				@r = Reservation.makePayment(r)
				@r.save
			end
		end
	end

end
