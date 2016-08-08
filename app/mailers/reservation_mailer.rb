class ReservationMailer < ApplicationMailer


	def reservation_email(customer, listing)
		@customer = customer
		@listing = listing
		mail(to: @customer.email, subject: 'Your reservation has been confirmed')
	end


	# create a method to send to the listing owner too! 
		
end

# $ redis-server
# $ rails s
# $ bundle exec sidekiq -q default -q mailers (this is when action mailer is integrated with active job)