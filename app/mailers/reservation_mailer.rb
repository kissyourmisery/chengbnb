class ReservationMailer < ApplicationMailer



	def reservation_email(customer, listing)
		@customer = customer
		@listing = listing
		mail(to: @customer.email, subject: 'Your reservation has been confirmed')
	end
		
end
