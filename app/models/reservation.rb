class Reservation < ActiveRecord::Base
	belongs_to :path
	belongs_to :first_station, :class_name => 'Station' 
	belongs_to :last_station, :class_name => 'Station'
	belongs_to :user

	

	def self.makePayment(res)
		res.paid = true;
		res.ticket = Base64.encode64(UUIDTools::UUID.random_create)[0..7]
		res
	end
end
